//
//  Coordinator.swift
//  SimpleLoginApp
//
//  Created by Dioniz Bardhaj on 8.10.21.
//

import SwiftUI

protocol Coordinating {
  func start()
}

protocol LoginViewNavigation: AnyObject {
  func didLogin()
}

class Coordinator: Coordinating {
  // MARK: - Properties

  var window: UIWindow
  private lazy var navigationController = UINavigationController()

  // MARK: - Initializers

  init(window: UIWindow) {
    self.window = window
  }

  // MARK: - Lifecycle
  func start() {
    let view = LoginView(loginViewModel: LoginViewModel(userDefaults: UserDefaults.standard), navigation: self)
    let viewController = UIHostingController(rootView: view)
    navigationController.setViewControllers([viewController], animated: true)
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }
}

// MARK: - LoginViewNavigation
extension Coordinator: LoginViewNavigation {
  func didLogin() {
    let view = HomeView()
    let viewController = UIHostingController(rootView: view)
    navigationController.pushViewController(viewController, animated: true)
  }
}
