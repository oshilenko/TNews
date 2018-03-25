//
//  RequestManager.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 24.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import Foundation

typealias Headers = [String: String]
typealias Parameters = [String: Any]
typealias Success<T> = (T) -> Void
typealias Failure = (Error?) -> Void
typealias RequestCompletion = (Data?, URLResponse?, Error?) -> Void

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

final class RequestManager: NSObject {
    // MARK: - Public variables
    static var isPrintedLogs: Bool = false
    
    // MARK: - Pivate variables
    private var session: URLSession!
    
    override init() {
        super.init()
        
        let configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
    }
}

extension RequestManager {
    func requestObject<T: Decodable>(method: HTTPMethod = .get,
                          baseURL: String,
                          path: String,
                          headers: Headers? = nil,
                          parameters: Parameters? = nil,
                          success: @escaping Success<T>,
                          failure: @escaping Failure) -> URLSessionDataTask? {
        return request(method: method, baseURL: baseURL, path: path, headers: headers,
                       parameters: parameters, completion: { [weak self] (data, response, error) in
                        guard let strongSelf = self else { return }
                        
                        let decoder = JSONDecoder()
                        
                        if let error = error {
                            failure(error)
                        } else if let response = response, let httpResponse = response as? HTTPURLResponse,
                            ([Int](200..<300)).contains(where: { $0 == httpResponse.statusCode }) {
                            strongSelf.printLogs(response.description)
                            
                            if let data = data, let jsonResponse = try? decoder.decode(ResponseObject<T>.self, from: data) {
                                if let object = jsonResponse.payload {
                                    success(object)
                                } else {
                                    failure(Constants.ServerError.jsonDecoding)
                                }
                            } else {
                                failure(Constants.ServerError.jsonDecoding)
                            }
                        } else {
                            failure(Constants.ServerError.nilResponse)
                        }
        })
    }
    
    func requestObjects<T: Decodable>(method: HTTPMethod = .get,
                          baseURL: String,
                          path: String,
                          headers: Headers? = nil,
                          parameters: Parameters? = nil,
                          success: @escaping Success<[T]>,
                          failure: @escaping Failure) -> URLSessionDataTask? {
        return request(method: method, baseURL: baseURL, path: path, headers: headers,
                       parameters: parameters, completion: { [weak self] (data, response, error) in
            guard let strongSelf = self else { return }
            
            let decoder = JSONDecoder()
            
            if let error = error {
                failure(error)
            } else if let response = response, let httpResponse = response as? HTTPURLResponse,
                ([Int](200..<300)).contains(where: { $0 == httpResponse.statusCode }) {
                strongSelf.printLogs(response.description)
                
                if let data = data, let jsonResponse = try? decoder.decode(ResponseObjects<T>.self, from: data) {
                    if let objects = jsonResponse.payload {
                        success(objects)
                    } else {
                        failure(Constants.ServerError.jsonDecoding)
                    }
                } else {
                    failure(Constants.ServerError.jsonDecoding)
                }
            } else {
                failure(Constants.ServerError.nilResponse)
            }
        })
    }
}

// MARK: - Private methods
private extension RequestManager {
    func request(method: HTTPMethod = .get,
                 baseURL: String,
                 path: String,
                 headers: Headers? = nil,
                 parameters: Parameters? = nil,
                 completion: @escaping RequestCompletion) -> URLSessionDataTask? {
        guard let url = URL(string: "\(baseURL)\(path)") else {
            print("Can't create URL for baseURL: \(baseURL) and path: \(path)")
            return nil
        }
        
        let urlRequest = configureUrlRequest(url: url, parameters: parameters, method: method)
        let task = session.dataTask(with: urlRequest, completionHandler: completion)
        task.resume()
        
        return task
    }
    
    func configure(parameters: Parameters) -> String {
        var components: [(String, String)] = []
        
        parameters.forEach { (key, value) in
            if let value = value as? Int {
                components.append((key, "\(value)"))
            }
        }
        
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }
    
    func configureUrlRequest(url: URL, parameters: Parameters?, method: HTTPMethod) -> URLRequest {
        var urlRequest = URLRequest(url: url,
                                    cachePolicy: session.configuration.requestCachePolicy,
                                    timeoutInterval: session.configuration.timeoutIntervalForRequest)
        urlRequest.httpMethod = method.rawValue
        
        if let parameters = parameters {
            switch method {
            case .get:
                if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
                    !parameters.isEmpty {
                    urlComponents.percentEncodedQuery = configure(parameters: parameters)
                    urlRequest.url = urlComponents.url
                }
            case .post:
                if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                    urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8",
                                        forHTTPHeaderField: "Content-Type")
                }
                
                let parametersString = configure(parameters: parameters)
                urlRequest.httpBody = parametersString.data(using: .utf8, allowLossyConversion: false)
            }
        }
        
        printLogs(urlRequest.description)
        
        return urlRequest
    }
    
    func printLogs(_ string: String) {
        print("[RequestManager] \(Date()): \(string)")
    }
}
