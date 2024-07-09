//
//  TestingNetworkTests.swift
//  TestingNetworkTests
//
//  Created by 류희재 on 7/8/24.
//


import XCTest
@testable import TestingLaboratory

class NetworkManagerTests: XCTestCase {
    
    var url: String!
    var data: Data!
    
    override func setUpWithError() throws {
        url = "https://api.sampleapis.com/userInfo/"
        data = JsonLoader.data(fileName: "UserInfo")
    }
    
    override func tearDownWithError() throws {
        url = nil
        data = nil
    }
    
    func test_fetchData_Data가_있고_statusCode가_200일때() {
        // given
        let mockURLSession = MockURLSession.make(url: url,
                                                 data: data,
                                                 statusCode: 200)
        let sut = NetworkManager(session: mockURLSession)
        
        // when
        var result: [SignInResponseNetworkTest]?
        sut.fetchData(for: url,
                      dataType: [SignInResponseNetworkTest].self) { response in
            if case let .success(userInfo) = response {
                result = userInfo
            }
        }
        
        // then
        let expectation: [SignInResponseNetworkTest]? = JsonLoader.load(type: [SignInResponseNetworkTest].self, fileName: "UserInfo")
        XCTAssertEqual(result?.count, expectation?.count)
        XCTAssertEqual(result?.first?.id, expectation?.first?.id)
        XCTAssertEqual(result?.first?.name, expectation?.first?.name)
    }
    
    func test_fetchData_Data가_있지만_decode에러일때_statusCode가_200일때() {
        // given
        let mockURLSession = MockURLSession.make(url: url,
                                                 data: data,
                                                 statusCode: 200)
        let sut = NetworkManager(session: mockURLSession)
        
        // when
        var result: Error?
        sut.fetchData(for: url,
                      dataType: SignInResponseNetworkTest.self) { response in
            if case let .failure(error) = response { // 이 구문은 response가 실패(.failure)한 경우에만 실행됩니다.
                if case NetworkError.decodedError = error {
                    result = error
                }
            }
            
            // then
            XCTAssertNotNil(result)
        }
    }
    
    func test_fetchData_Data가_있고_statusCode가_500일때() {
        // given
        let mockURLSession = MockURLSession.make(url: url,
                                                 data: data,
                                                 statusCode: 500)
        let sut = NetworkManager(session: mockURLSession)
        
        
        // when
        var result: Error?
        sut.fetchData(for: url,
                      dataType: [SignInResponseNetworkTest].self) { response in
            if case let .failure(error) = response { // 이 구문은 response가 실패(.failure)한 경우에만 실행됩니다.
                if case NetworkError.serverErr = error {
                    result = error
                }
            }
            
            // then
            XCTAssertNotNil(result)
        }
    }
    
    func test_fetchData_Data가_있고_statusCode가_400번대일때() {
        // given
        let mockURLSession = MockURLSession.make(url: url,
                                                 data: data,
                                                 statusCode: 404)
        let sut = NetworkManager(session: mockURLSession)
        
        
        // when
        var result: Error?
        sut.fetchData(for: url,
                      dataType: [SignInResponseNetworkTest].self) { response in
            if case let .failure(error) = response {
                if case NetworkError.requestErr = error {
                    result = error
                }
            }
            
            // then
            XCTAssertNotNil(result)
        }
    }
}
