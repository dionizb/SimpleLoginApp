//
//  UserDefaults.swift
//  SimpleLoginApp
//
//  Created by Dioniz Bardhaj on 8.10.21.
//

import Foundation

enum UserDefaultKey: String {
  case userBiomentricsEnabled
}

protocol UserDefaulting {
  func bool(for key: UserDefaultKey) -> Bool
  func set(_ value: Bool, for key: UserDefaultKey)
}

extension UserDefaults: UserDefaulting {
  func bool(for key: UserDefaultKey) -> Bool {
    bool(forKey: key.rawValue)
  }

  func set(_ value: Bool, for key: UserDefaultKey) {
    set(value, forKey: key.rawValue)
  }
}
