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

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSearchController()
  }

  private func setUpSearchController() {
    navigationItem.titleView = segmentedControl
    navigationItem.searchController = searchController
  }
}
