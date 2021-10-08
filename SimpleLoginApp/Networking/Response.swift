//
//  Response.swift
//  SimpleLoginApp
//
//  Created by Dioniz Bardhaj on 8.10.21.
//

class Response<T: Codable>: Codable {
  var data: T?
}
