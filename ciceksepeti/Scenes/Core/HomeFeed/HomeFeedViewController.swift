//
//  HomeFeedViewController.swift
//  ciceksepeti
//
//  Created by Emir Alkal on 21.01.2023.
//

import SnapKit
import UIKit

final class HomeFeedViewController: UIViewController {
  private let viewModel = HomeFeedViewModel()

  private let segmentedControl: UISegmentedControl = {
    let segmentedControl = UISegmentedControl(items: [
      UIImage(named: Images.topSectionLeft.rawValue)!.withRenderingMode(.alwaysOriginal),
      UIImage(named: Images.topSectionRight.rawValue)!.withRenderingMode(.alwaysOriginal)
    ])
    segmentedControl.selectedSegmentTintColor = .systemTeal
    segmentedControl.selectedSegmentIndex = 0
    segmentedControl.heightAnchor.constraint(equalToConstant: 44).isActive = true
    segmentedControl.layer.borderWidth = 1
    segmentedControl.layer.borderColor = UIColor.secondaryLabel.cgColor
    return segmentedControl
  }()

  private let searchController: UISearchController = {
    let searchController = UISearchController(searchResultsController: UIViewController())
    let textField = searchController.searchBar.searchTextField
    textField.borderStyle = .none
    textField.layer.cornerRadius = 4
    textField.layer.borderWidth = 1
    textField.layer.borderColor = UIColor.secondaryLabel.cgColor
    textField.placeholder = "Marka, ürün veya kategori ara"
    textField.snp.makeConstraints { make in
      make.bottom.equalToSuperview().offset(-6)
      make.leading.equalToSuperview().offset(8)
      make.trailing.equalToSuperview().offset(-8)
      make.height.equalTo(36)
    }
    return searchController
  }()

  private lazy var collectionView: UICollectionView = {
    let compositionalLayout = UICollectionViewCompositionalLayout { sectionIndex, _ in
      self.viewModel.getSection(sectionIndex)
    }
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
    collectionView.backgroundColor = .secondarySystemBackground
    return collectionView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpNavigationController()
    setUpCollectionView()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    setUpSlidingEffect()
  }

  private func setUpSlidingEffect() {
    viewModel.indexForSlide.bind { [unowned self] i in
      let indexPath = IndexPath(item: i, section: 1)
      let scrollPosition: UICollectionView.ScrollPosition = indexPath.item == 0 ? .right : .left
      self.collectionView.scrollToItem(at: indexPath, at: scrollPosition, animated: true)
    }

    viewModel.startAnimating()
  }

  private func setUpNavigationController() {
    navigationItem.titleView = segmentedControl
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
  }

  private func setUpCollectionView() {
    view.addSubview(collectionView)
    collectionView.dataSource = self
    collectionView.delegate = self

    collectionView.register(HeaderCell.self, forCellWithReuseIdentifier: HeaderCell.identifier)
    collectionView.register(SlideCell.self, forCellWithReuseIdentifier: SlideCell.identifier)
    collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)

    collectionView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
  }

  deinit {
    viewModel.endAnimating()
  }
}

extension HomeFeedViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentSize != .zero {
      guard let item = collectionView.cellForItem(at: IndexPath(item: 0, section: 1)) else { return }
      viewModel.scrolled(
        contentOffset: scrollView.contentOffset.y,
        minYframe: item.frame.minY
      )
    }
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let vc = CategoriesDetailViewController()
    vc.viewModel = CategoriesDetailViewModel(indexPath: indexPath)
    navigationController?.pushViewController(vc, animated: true)
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    3
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch section {
    case 0:
      return HeaderCellMock.data.count
    case 1:
      return SlideCellMock.data.count
    case 2:
      return CategoryCellMock.data.count
    default:
      return 0
    }
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.section == 0 {
      guard let item = collectionView
        .dequeueReusableCell(withReuseIdentifier: HeaderCell.identifier, for: indexPath) as? HeaderCell
      else { fatalError() }

      item.configure(with: HeaderCellMock.data[indexPath.item])
      return item

    } else if indexPath.section == 1 {
      guard let item = collectionView
        .dequeueReusableCell(withReuseIdentifier: SlideCell.identifier, for: indexPath) as? SlideCell
      else { fatalError() }

      item.configure(with: SlideCellMock.data[indexPath.item])
      return item

    } else if indexPath.section == 2 {
      guard let item = collectionView
        .dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell
      else { fatalError() }

      item.configure(with: CategoryCellMock.data[indexPath.row])
      return item
    }
    // TODO:
    return .init()
  }
}
