//
//  Error.swift
//  SimpleLoginApp
//
//  Created by Dioniz Bardhaj on 8.10.21.
//

internal enum ErrorType {
  case backend
  case data
  case decoding
  case statusCode
  case urlCasting
  case characterNotFound
  case wrongUrl
}

internal struct CustomError: Error, Equatable {
  internal var description: String
  internal var errorCode: Int?
  internal var errorType: ErrorType
}
