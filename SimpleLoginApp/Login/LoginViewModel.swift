//
//  LoginViewModel.swift
//  SimpleLoginApp
//
//  Created by Dioniz Bardhaj on 7.10.21.
//

import AuthenticationServices
import Combine
import LocalAuthentication

final class LoginViewModel: NSObject, ObservableObject {
  // MARK: - Properties

  var userDefaults: UserDefaulting
  private var cancellables = Set<AnyCancellable>()
  @Published var isLoggedId: Bool = false
  @Published var authorizationError: Error?

  // MARK: - Initializers

  init(userDefaults: UserDefaulting) {
    self.userDefaults = userDefaults
  }

  // MARK: Actions

  func checkBiometrics() {
    guard userDefaults.bool(for: .userBiomentricsEnabled) else {
      return
    }

    let context = LAContext()
    let authenticate = Future<Void, Error> { promise in
      context.evaluatePolicy(
        .deviceOwnerAuthenticationWithBiometrics,
        localizedReason: "Authenticate now!",
        reply: { isSuccess, error in
          isSuccess ? promise(.success(())) : promise(.failure(error!))
        }
      )
    }
  
    authenticate
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          self.isLoggedId = false
          self.authorizationError = error
        case .finished:
          self.isLoggedId = true
        }
      }, receiveValue: { _ in })
      .store(in: &cancellables)
  }
}

// MARK: - ASAuthorizationControllerDelegate

extension LoginViewModel: ASAuthorizationControllerDelegate {
  func authorizationController(
    controller: ASAuthorizationController,
    didCompleteWithAuthorization authorization: ASAuthorization
  ) {
    switch authorization.credential {
    case let appleIdCredential as ASAuthorizationAppleIDCredential:
      if let _ = appleIdCredential.email, let _ = appleIdCredential.fullName {
        registerNewUser(credential: appleIdCredential)
      } else {
        signInExistingUser(credential: appleIdCredential)
      }
    case let passwordCredential as ASPasswordCredential:
      signinWithUserNamePassword(credential: passwordCredential)
    default:
      break
    }
  }
  
  func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    if error._code == 1001 {
      // send user next screen
      DispatchQueue.main.async { [weak self] in
        self?.isLoggedId = false
      }
    }
    print("\n -- ASAuthorizationControllerDelegate -\(#function) -- \n")
    print(error)
  }

  private func registerNewUser(credential: ASAuthorizationAppleIDCredential) {
    // TODO: Create an API Request
    // API Call - Pass the email, user full name, user identity provided by Apple and other details.
    DispatchQueue.main.async { [weak self] in
      self?.isLoggedId = true
    }
  }
  
  private func signInExistingUser(credential: ASAuthorizationAppleIDCredential) {
    // TODO: Create an API Request
    // API Call - Pass the user identity, authorizationCode and identity token
    DispatchQueue.main.async { [weak self] in
      self?.isLoggedId = true
    }
  }
  
  private func signinWithUserNamePassword(credential: ASPasswordCredential) {
    // TODO: Create an API Request
    // API Call - Sign in with Username and password
    DispatchQueue.main.async { [weak self] in
      self?.isLoggedId = true
    }
  }
}

