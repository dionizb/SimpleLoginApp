//
//  BaseRequest.swift
//  SimpleLoginApp
//
//  Created by Dioniz Bardhaj on 8.10.21.
//

import Foundation

// TODO: TO be used later for requests
enum Url: String {
  case base = ""
}

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
}

protocol BaseRequest {
    var httpMethod: HTTPMethod { get }
    var body: [String: Any] { get }
    var dataBody: Data? { get }
    var headers: [String: String] { get }
    var base: Url { get }
    var endpoint: Url { get }
    var urlString: String { get }
}

extension BaseRequest {
    var httpMethod: HTTPMethod {
        .post
    }
    
    var headers: [String: String] {
        [:]
    }
    
    var base: Url {
        return Url.base
    }
    
    var urlString: String {
        return base.rawValue.appending(endpoint.rawValue)
    }
}
