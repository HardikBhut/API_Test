//
//  RestAPI.swift
//  Test
//
//  Created by Hardik Bhut on 03/06/24.
//

import Foundation

class URLSessionManager {
    static let shared = URLSessionManager()
    
    private let session: URLSession
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30.0
        configuration.timeoutIntervalForResource = 60.0
        session = URLSession(configuration: configuration)
    }
    
    func sendRequest<T: Codable>(url: URL, method: String, body: T?, completion: @escaping (Result<Data, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body = body {
            do {
                let encoder = JSONEncoder()
                request.httpBody = try encoder.encode(body)
            } catch {
                completion(.failure(error))
                return
            }
        }
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                let statusError = NSError(domain: "Invalid response", code: (response as? HTTPURLResponse)?.statusCode ?? 0, userInfo: nil)
                completion(.failure(statusError))
                return
            }
            
            guard let data = data else {
                let noDataError = NSError(domain: "No data", code: 0, userInfo: nil)
                completion(.failure(noDataError))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
    
    func sendRequest(url: URL, method: String, completion: @escaping (Result<Data, Error>) -> Void) {
        sendRequest(url: url, method: method, body: Optional<EmptyBody>.none, completion: completion)
    }
    
    private struct EmptyBody: Codable {}
}
