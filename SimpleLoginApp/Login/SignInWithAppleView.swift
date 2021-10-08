//
//  SignInWithAppleView.swift
//  SimpleLoginApp
//
//  Created by Dioniz Bardhaj on 7.10.21.
//

import AuthenticationServices
import SwiftUI

struct SignInWithAppleView: UIViewRepresentable {
  // MARK: - Properties

  @Environment(\.colorScheme) var colorScheme
  
  typealias UIViewType = ASAuthorizationAppleIDButton

  // MARK: - UIViewRepresentable

  func makeUIView(context: Context) -> UIViewType {
    return ASAuthorizationAppleIDButton(
      type: .signIn,
      style: colorScheme == .dark ? .white : .black
    )
  }
  
  func updateUIView(_ uiView: UIViewType, context: Context) {}
}

struct SignInWithAppleView_Previews: PreviewProvider {
  static var previews: some View {
    SignInWithAppleView()
  }
}
