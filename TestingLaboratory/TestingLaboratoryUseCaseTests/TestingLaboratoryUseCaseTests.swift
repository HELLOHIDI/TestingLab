//
//  TestingLaboratoryTests.swift
//  TestingLaboratoryTests
//
//  Created by 류희재 on 6/29/24.
//

//import XCTest
//@testable import TestingLaboratory
//
//final class TestingLaboratoryUseCaseTests: XCTestCase {
//    
//    var mockAuthRepository: AuthRepository!
//    var sut: AuthUseCase!
//
//    override func setUpWithError() throws {
//        mockAuthRepository = MockAuthRepository()
//        sut = DefaultAuthUseCase(
//            repository: self.mockAuthRepository
//        )
//    }
//
//    override func tearDownWithError() throws {
//        mockAuthRepository = nil
//        sut = nil
//    }
//
//    func test_유효하지않은_이메일_테스트() async throws {
//        // Given
//        let ids = [
//            "dsflkjasf@aslssdkadsf",
//            "dsflkjasf@aslssdkadsf",
//            "dsflkjasf@aslssdkadsf",
//            "dsflkjasf@aslssdkadsf"
//        ]
//        let password = "dave1072!A"
//        
//        for id in ids {
//            do {
//                _ = try await sut.signIn(id, password)
//                XCTAssert(false)
//            } catch let error as AuthError {
//                XCTAssertEqual(error, AuthError.invalidEmail)
//            } catch {
//                XCTAssert(false)
//            }
//        }
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//
//}

import XCTest
@testable import TestingLaboratory

final class TestingLaboratoryUseCaseTests: XCTestCase {
  
    var mockAuthRepository: AuthRepository!
    var sut: AuthUseCase!

    override func setUpWithError() throws {
        mockAuthRepository = MockAuthRepository()
        sut = DefaultAuthUseCase(repository: mockAuthRepository)
    }

    override func tearDownWithError() throws {
        mockAuthRepository = nil
        sut = nil
    }
    
    func test_signIn_유효하지_않은_이메일을_잘_걸러내나요() async throws {
        //given
        let ids = [
            "seokwoo2000.naver.com",
            "seokwoo2000@.com",
            "seok@1.1"
            
        ]
        let pw = "myPassword12!"
        
        for id in ids {
            do {
                //when
                _ = try await sut.signIn(id, pw)
                
                XCTAssert(false) // 실행되면 안되는 코드
            } catch let error as AuthError {
                
                //then
                XCTAssertEqual(error, AuthError.invalidEmail)
            } catch  {
                XCTAssertTrue(false) // 실행되면 안되는 코드
            }
        }
        
        
    }

    

}
