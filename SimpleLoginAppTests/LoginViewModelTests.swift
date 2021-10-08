//
//  LoginViewModelTests.swift
//  SimpleLoginAppTests
//
//  Created by Dioniz Bardhaj on 8.10.21.
//

import XCTest
@testable import SimpleLoginApp

class LoginViewModelTests: XCTestCase {
  // MARK: - Properties

  var loginViewModel: LoginViewModel!
  var userDefaultingMock: UserDefaultingMock!

  // MARK: - Lifecycle

  override func setUpWithError() throws {
    self.userDefaultingMock = UserDefaultingMock()
    loginViewModel = LoginViewModel(userDefaults: userDefaultingMock)
  }

  // MARK: - Tests

  func testLogin() {
    loginViewModel.checkBiometrics()

    XCTAssertEqual(1, userDefaultingMock.calledCount.readBool)
    XCTAssertEqual(0, userDefaultingMock.calledCount.writeBool)
  }
}
