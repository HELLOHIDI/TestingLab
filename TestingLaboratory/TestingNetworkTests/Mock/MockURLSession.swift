//
//  MockURLSession.swift
//  TestingNetworkTests
//
//  Created by 류희재 on 7/8/24.
//

/// 즉 resume 호출이 실제 api call 을 때리는게 아니기 때문에 URLSessionDataTask 에 대한 Mock 객체도 만들어주겠음요
import Foundation

class MockURLSession: URLSessionProtocol {
    
    typealias Response = (data: Data?, urlResponse: URLResponse?, error: Error?)
    
    let response: Response
    
    init(response: Response) {
        self.response = response
    }
    
    func dataTask(with url: URL,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return MockURLSessionDataTask(resumeHandler: {
            completionHandler(self.response.data,
                              self.response.urlResponse,
                              self.response.error)
        })
    }
    
    static func make(url: String, data: Data?, statusCode: Int) -> MockURLSession {
        let mockURLSession: MockURLSession = {
            let urlResponse = HTTPURLResponse(url: URL(string: url)!,
                                              statusCode: statusCode,
                                              httpVersion: nil,
                                              headerFields: nil)
            let mockResponse: MockURLSession.Response = (data: data,
                                                         urlResponse: urlResponse,
                                                         error: nil)
            let mockUrlSession = MockURLSession(response: mockResponse)
            return mockUrlSession
        }()
        return mockURLSession
    }
}
