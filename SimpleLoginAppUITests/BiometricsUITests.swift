//
//  Biometrics.swift
//  SimpleLoginAppUITests
//
//  Created by Dioniz Bardhaj on 8.10.21.
//

import XCTest

class BiometricsUITests: XCTestCase {
  // MARK: - Properties

  let app = XCUIApplication()
  
  // MARK: - Tests

  func test_launchingWithBiometricsDisabled() {
    Biometrics.unenrolled()
    app.launch()
    let text = app.staticTexts.element(matching: .any, identifier: "StatusText").label
    XCTAssertEqual("Locked", text)
  }
  
  func test_launchingWithBiometricsEnabled() {
    Biometrics.enrolled()
    app.launch()
    Biometrics.successfulAuthentication()
    let text = app.staticTexts.element(matching: .any, identifier: "StatusText").label
    XCTAssertEqual("Unlocked", text)
    XCTAssertTrue(app.staticTexts.element(matching: .any, identifier: "HomeLabel").exists)
  }
}
