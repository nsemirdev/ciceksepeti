//
//  CategoriesDetailViewController.swift
//  ciceksepeti
//
//  Created by Emir Alkal on 23.01.2023.
//

import UIKit

final class CategoriesDetailViewController: UIViewController {
  var viewModel: CategoriesDetailViewModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemTeal
    print(viewModel?.indexPath)
  }
}
