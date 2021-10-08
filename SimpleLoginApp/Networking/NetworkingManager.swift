//
//  NetworkingManager.swift
//  SimpleLoginApp
//
//  Created by Dioniz Bardhaj on 8.10.21.
//

import Combine
import Foundation

protocol Networking {
  func request()
}

class NetworkingManager {
  // MARK: - Properties
  
  var session: URLSession
  
  // MARK: - Initializers
  
  init (session: URLSession) {
    self.session = session
  }
  
  func doRequest<T: Decodable>(from urlRequest: URLRequest) -> AnyPublisher<Response<T>, Error> {
    session
      .dataTaskPublisher(for: urlRequest)
      .tryMap { result -> Response<T>  in
        guard let response = result.response as? HTTPURLResponse else {
          let customError = CustomError(description: "Something went wrong", errorType: .urlCasting)
          throw customError
        }
        
        guard (200...299).contains(response.statusCode) else {
          let customError = CustomError(description: "Something went wrong", errorCode: response.statusCode, errorType: .statusCode)
          throw customError
        }

        return try JSONDecoder().decode(Response<T>.self, from: result.data)
      }
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }

  func execute<T: Decodable>(baseRequest: BaseRequest) -> AnyPublisher<Response<T>, Error> {
    guard let url = URL(string: baseRequest.urlString) else {
      fatalError("Wrong URL String")
    }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.allHTTPHeaderFields = baseRequest.headers
    urlRequest.httpMethod = baseRequest.httpMethod.rawValue
    urlRequest.httpBody = baseRequest.dataBody ?? Data()
    
    return doRequest(from: urlRequest)
  }
}

