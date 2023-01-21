//
//  HomeFeedViewController.swift
//  ciceksepeti
//
//  Created by Emir Alkal on 21.01.2023.
//

import SnapKit
import UIKit

final class HomeFeedViewController: UIViewController {
  private let segmentedControl: UISegmentedControl = {
    let segmentedControl = UISegmentedControl(items: ["ali", "veli"])
    segmentedControl.sizeToFit()
    segmentedControl.selectedSegmentTintColor = .systemTeal
    segmentedControl.selectedSegmentIndex = 0
    segmentedControl.setImage(UIImage(named: "cicek-sepeti-logo-2")?.withRenderingMode(.alwaysOriginal), forSegmentAt: 0)
    segmentedControl.setImage(UIImage(named: "extra-logo-200")?.withRenderingMode(.alwaysOriginal), forSegmentAt: 1)
    segmentedControl.heightAnchor.constraint(equalToConstant: 44).isActive = true
    segmentedControl.layer.borderWidth = 1
    segmentedControl.layer.borderColor = UIColor.secondaryLabel.cgColor
    return segmentedControl
  }()

  private let searchController: UISearchController = {
    let searchController = UISearchController(searchResultsController: UIViewController())
    searchController.searchBar.searchTextField.backgroundColor = .white
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

  private let collectionView: UICollectionView = {
    let compositionalLayout = UICollectionViewCompositionalLayout { sectionIndex, _ in
      switch sectionIndex {
      case 0:
        return CompositionalLayoutHelper.createFirstSection()
      case 1:
        return CompositionalLayoutHelper.createSecondSection()
      case 2:
        return CompositionalLayoutHelper.createThirdSection()
      default:
        return nil
      }
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

  private func setUpNavigationController() {
    navigationItem.titleView = segmentedControl
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
  }

  private func setUpCollectionView() {
    view.addSubview(collectionView)
    collectionView.dataSource = self
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "item")

    collectionView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
  }
}

extension HomeFeedViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    3
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 10
    case 1:
      return 2
    case 2:
      return 20
    default:
      return 0
    }
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let item = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath)
    if indexPath.section == 0 {
      item.backgroundColor = .blue
    } else if indexPath.section == 1 {
      item.backgroundColor = .red
      item.layer.cornerRadius = 12
    } else if indexPath.section == 2 {
      item.backgroundColor = .systemTeal
      item.layer.cornerRadius = 8
    }
    return item
  }
}
