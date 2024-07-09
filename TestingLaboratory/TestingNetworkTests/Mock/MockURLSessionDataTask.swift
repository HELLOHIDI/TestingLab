//
//  MockURLSessionDataTask.swift
//  TestingNetworkTests
//
//  Created by 류희재 on 7/8/24.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    
    /// resume 호출 시 같이 실행하기 위해 미리 넘겨 받은 클로저
    private let resumeHandler: () -> Void
    
    init(resumeHandler: @escaping () -> Void) {
        self.resumeHandler = resumeHandler
    }
    
    /// resume 해도 실제 네트워크 요청이 일어나면 안 되기에, 그냥 단순히 completionHandler 호출
    func resume() {
        resumeHandler()
    }
}
