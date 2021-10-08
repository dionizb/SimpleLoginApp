//
//  ContentView.swift
//  SimpleLoginApp
//
//  Created by Dioniz Bardhaj on 7.10.21.
//

import AuthenticationServices
import SwiftUI

struct LoginView: View {
  // MARK: - Properties

  private weak var navigation: LoginViewNavigation?
  @ObservedObject private var loginViewModel: LoginViewModel

  // MARK: - Init

  init(loginViewModel: LoginViewModel, navigation: LoginViewNavigation?) {
    self.loginViewModel = loginViewModel
    self.navigation = navigation
  }

  // MARK: - UI

  var body: some View {
    SignInWithAppleView()
      .frame(width: 280, height: 60, alignment: .center)
      .cornerRadius(8)
      .onTapGesture(perform: showAppleLoginView)
    VStack {
      if loginViewModel.isLoggedId {
        Text("Unlocked")
          .foregroundColor(.white)
          .accessibilityIdentifier("StatusText")
        let _ = navigation?.didLogin()
      } else {
        Text("Locked")
          .foregroundColor(.red)
          .accessibilityIdentifier("StatusText")
      }
    }
    .onAppear(perform: loginViewModel.checkBiometrics)
  }
  
  private func showAppleLoginView() {
    let provider = ASAuthorizationAppleIDProvider()
    let request = provider.createRequest()
    request.requestedScopes = [.fullName, .email]
    let controller = ASAuthorizationController(authorizationRequests: [request])
    controller.delegate = loginViewModel
    controller.performRequests()
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      LoginView(loginViewModel: LoginViewModel(userDefaults: UserDefaults.standard), navigation: nil)
    }
}
