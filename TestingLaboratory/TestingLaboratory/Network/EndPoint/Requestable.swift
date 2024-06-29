//
//  Requestable.swift
//  TestingLaboratory
//
//  Created by 류희재 on 6/30/24.
//

import Foundation

protocol Requestable {
    var baseURL: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var body: Encodable? { get }
}

extension Requestable {
    func getUrlRequest() throws -> URLRequest {
        let url = try url()
        var urlRequest = URLRequest(url: url)
        
        // httpBody
        if let body = try body?.toDictionary() {
            if !body.isEmpty {
                urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)
            }
        }
        
        // httpMethod
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
    
    func url() throws -> URL {
        
        // baseURL + path
        let fullPath = "\(baseURL)\(path)"
        guard let urlComponents = URLComponents(string: fullPath) else { throw AuthError.unknown }
        
        guard let url = urlComponents.url else { throw AuthError.unknown }
        return url
    }
}

extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? [String: Any]
    }
}
