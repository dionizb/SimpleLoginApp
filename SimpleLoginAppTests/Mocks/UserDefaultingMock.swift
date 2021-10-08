//
//  UserDefaultingMock.swift
//  SimpleLoginAppTests
//
//  Created by Dioniz Bardhaj on 8.10.21.
//

import XCTest
@testable import SimpleLoginApp

class UserDefaultingMock: UserDefaulting {
  // MARK: - Properties

  struct CalledCount {
      var writeBool = 0
      var readBool = 0
  }
  
  struct ReturnType {
      var readBool = true
  }
  
  // MARK: Mutables
  
  var calledCount = CalledCount()
  let returnType = ReturnType()

  func bool(for key: UserDefaultKey) -> Bool {
    calledCount.readBool += 1
    return returnType.readBool
  }
  
  func set(_ value: Bool, for key: UserDefaultKey) {
    calledCount.writeBool += 1
  }
}
