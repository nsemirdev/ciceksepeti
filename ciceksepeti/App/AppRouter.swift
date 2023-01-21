//
//  AppRouter.swift
//  ciceksepeti
//
//  Created by Emir Alkal on 21.01.2023.
//

import UIKit

final class AppRouter {
  var window: UIWindow?

  func start(_ windowScene: UIWindowScene) {
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = MainTabBarViewController()
    window?.makeKeyAndVisible()
  }
}
