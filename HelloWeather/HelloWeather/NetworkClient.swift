
//
//  NetworkClient.swift
//  HelloWeather
//
//  Created by Sarvesh Suryavanshi on 18/11/21.
//

import Foundation


/// Enum describing API Errors
enum APIError: Error {
    case badRequest
    case networkError
    case failedToLoad
    case failedToDecode
}

class NetworkClient {
    
    /// Loads and Parses given request into given Codable output model
    class func loadAndParse<T: Codable>(request: URLRequest?, decoder: JSONDecoder? = nil, outputType: T.Type, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let request = request else { return completion(.failure(.badRequest)) }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil, let httpResponse = response, httpResponse.isOK else {
                return completion(.failure(.failedToLoad))
            }
            
            let decoder = decoder ?? JSONDecoder()
           decoder.dateDecodingStrategy = .formatted(DateFormatter.parsingDF)
            
            do {
                // Printing response here for reviewer of the asignment
                if let jsonString = String(data: data, encoding: .utf8) { print(jsonString) }
                let outputModel = try decoder.decode(outputType, from: data)
               
                
                //DispatchQueue.main.async { LocalStorageManager.shared.save() }
                
                
                completion(.success(outputModel))
            } catch let decodingError {
                print(decodingError.localizedDescription)
                completion(.failure(.failedToDecode))
            }
        }.resume()
    }
}

private extension URLResponse {
    
    var isOK: Bool {
        guard let statusCode = (self as? HTTPURLResponse)?.statusCode else {
            return false
        }
        switch statusCode {
        case 200..<300:
            return true
        default:
            return false
        }
    }
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "Context")
}

