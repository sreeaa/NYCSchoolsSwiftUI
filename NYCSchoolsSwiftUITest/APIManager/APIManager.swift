//
//  APIManager.swift
//  NYCSchoolsSwiftUITest
//
//  Created by Akshitha atmakuri on 7/10/23.
//

import Foundation

protocol APIManagerProtocol {
    func request<T: Decodable>(session: URLSession, _ urlString: String) async throws -> T
}

class APIManager: APIManagerProtocol {
    
    static let shared = APIManager()
    
    private init() {
        
    }
    
    func request<T: Decodable>(session: URLSession, _ urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            print("unable to form url object from url string")
            throw NetworkingError.invalidURL
        }
        let request = URLRequest(url: url)
        let response: (Data, URLResponse)
        
        do {
            response = try await session.data(for: request)
        } catch {
            throw NetworkingError.custom(error: error)
        }
        
        let httpResponse = response.1 as! HTTPURLResponse
        guard (200...300) ~= httpResponse.statusCode else {
            throw NetworkingError.invalidStatusCode(statusCode: httpResponse.statusCode)
        }
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let data = try jsonDecoder.decode(T.self, from: response.0)
            return data
        } catch {
            throw NetworkingError.unableToDecode
        }
        
    }
    
}

extension APIManager {
    enum NetworkingError: Error {
        case invalidURL
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case unableToDecode
    }
}

extension APIManager.NetworkingError: Equatable {
    static func == (lhs: APIManager.NetworkingError, rhs: APIManager.NetworkingError) -> Bool {
        switch (lhs, rhs) {
            case (.invalidURL, .invalidURL):
                return true
            case let (.custom(lhsError), .custom(rhsError)):
                return lhsError.localizedDescription == rhsError.localizedDescription
            case let (.invalidStatusCode(lhsCode), .invalidStatusCode(rhsCode)):
                return lhsCode == rhsCode
            case (.unableToDecode, .unableToDecode):
                return true
            default:
                return false
        }
    }
}
