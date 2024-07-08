//
//  TestingLaboratoryTests.swift
//  TestingLaboratoryTests
//
//  Created by 류희재 on 6/29/24.
//

import XCTest
@testable import TestingLaboratory

final class TestingLaboratoryUseCaseTests: XCTestCase {
    
    var mockAuthRepository: AuthRepository!
    var sut: AuthUseCase!
    
    override func setUpWithError() throws {
        mockAuthRepository = MockAuthRepository()
        sut = DefaultAuthUseCase(
            repository: self.mockAuthRepository
        )
    }
    
    override func tearDownWithError() throws {
        mockAuthRepository = nil
        sut = nil
    }
    
    func test_유효하지않은_이메일_테스트() async throws {
        // Given
        let ids = [
            "seokwoo2000.naver.com",
            "seokwoo2000@.com",
            "seok@1.1"
            
        ]
        let password = "dave1072!A"
        
        for id in ids {
            do {
                _ = try await sut.signIn(id, password)
                XCTAssert(false)
            } catch let error as AuthError {
                XCTAssertEqual(error, AuthError.invalidEmail)
            } catch {
                XCTAssert(false)
            }
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
