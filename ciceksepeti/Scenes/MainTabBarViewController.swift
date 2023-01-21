//
//  MainTabBarViewController.swift
//  ciceksepeti
//
//  Created by Emir Alkal on 21.01.2023.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setUpAppearance()
    setUpTabBar()
  }

  private func setUpTabBar() {
    let titles = ["Anasayfa", "Kategoriler", "Favorilerim", "Sepetim", "Hesabım"]
    let images = [UIImage(systemName: "house"), UIImage(systemName: "magnifyingglass"), UIImage(systemName: "heart"), UIImage(systemName: "basket"), UIImage(systemName: "person")]

    let controllers = [
      UINavigationController.make(HomeFeedViewController()),
      UINavigationController.make(CategoriesViewController()),
      UINavigationController.make(FavoritesViewController()),
      UINavigationController.make(BasketViewController()),
      UINavigationController.make(ProfileViewController()),
    ]

    for (idx, controller) in controllers.enumerated() {
      controller.tabBarItem.image = images[idx]
      controller.tabBarItem.title = titles[idx]
    }

    viewControllers = controllers
  }

  private func setUpAppearance() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()

    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
    UINavigationBar.appearance().prefersLargeTitles = true
  }
}

// Builder pattern
extension UINavigationController {
  static func make(_ viewController: UIViewController) -> UINavigationController {
    UINavigationController(rootViewController: viewController)
  }
}
