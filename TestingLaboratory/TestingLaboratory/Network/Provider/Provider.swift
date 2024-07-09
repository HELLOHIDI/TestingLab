//
//  HTTPMethod.swift
//  TestingLaboratory
//
//  Created by 류희재 on 6/30/24.
//

import Foundation

final class Provider {
    func request<Response: Decodable, E: Requestable>(
        with endPoint: E,
        dto: Response.Type
    ) async throws -> Response {
        
        let urlRequest = try endPoint.getUrlRequest()
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard response is HTTPURLResponse else {
            throw NSError()
        }
        
        return try JSONDecoder().decode(dto, from: data)
    }
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

