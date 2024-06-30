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

//class URLSessionProvider {
//    let session: URLSession
//    let baseURL = "https://www.testwebpage.com/"
//    
//    init(session: URLSession = URLSession.shared) {
//        self.session = session
//    }
//    
//    func dataTask(request: URLRequest, completionHandler: @escaping (Result<Data, CustomError>) -> Void) {
//        
//        let task = session.dataTask(with: request) { data, urlResponse, error in
//            
//            guard let httpResponse = urlResponse as? HTTPURLResponse,
//                  (200...299).contains(httpResponse.statusCode) else {
//                return completionHandler(.failure(.statusCodeError))
//            }
//            
//            if let data = data {
//                return completionHandler(.success(data))
//            }
//            
//            completionHandler(.failure(.unknownError))
//        }
//        task.resume()
//    }
//}
