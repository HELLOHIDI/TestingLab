//
//  TestingLaboratoryRepositoryTests.swift
//  TestingLaboratoryRepositoryTests
//
//  Created by 류희재 on 7/1/24.
//

import XCTest

final class TestingLaboratoryRepositoryTests: XCTestCase {
    
    private var mockAuthService: AuthService!
    private var authRepository: AuthRepository!
    
    override func setUpWithError() throws {
        mockAuthService = MockAuthService()
        authRepository = DefaultAuthRepository(
            authService: self.mockAuthService
        )
    }
    
    override func tearDownWithError() throws {
        self.mockAuthService = nil
        self.authRepository = nil
    }
    
    func test_회원가입_중복이메일일때() async throws {
        // Given
        let id = "fbgmlwo123@naver.com"
        let password = "dave1072!A"
        let expectation = XCTestExpectation(description: "Sign up fails with alreadyExistEmail error")
        
        // When
        Task {
            do {
                try await authRepository.signUp(id: id, password: password)
                XCTFail("Expected alreadyExistEmail error but succeeded")
            } catch AuthError.alreadyExistEmail { // 중복된 이메일인 경우
                expectation.fulfill() // 결과에 충족한 경우
            } catch {
                XCTFail("Expected alreadyExistEmail error but got \(error)")
            }
        }
        
        // Then
        await fulfillment(of: [expectation], timeout: 1.0)
    }
    
    
    func test_회원가입_성공했을때() async throws {
        // Given
        let id = "fbgmlwo1072@naver.com"
        let password = "dave1072!A"

        // When
        do {
            try await authRepository.signUp(id: id, password: password)
            // Then
            // 에러가 발생하지 않으면 테스트 성공
        } catch {
            XCTFail("Expected no error but got \(error)")
        }
    }
    
    func test_로그인_성공했을때() async throws {
        // Given
        let id = "dave2000@gmail.com"
        let password = "aa1072!"

        // When
        do {
            try await authRepository.signIn(id: id, password: password)
            // Then
            // 에러가 발생하지 않으면 테스트 성공
        } catch {
            XCTFail("Expected no error but got \(error)")
        }
    }
    
    func test_비밀번호_틀렸을때() async throws {
        let id = "dave2000@gmail.com"
        let password = "aa1072"
        
        let expectation = XCTestExpectation(description: "비밀번호가 올바르지 않습니다!")
        
        // When
        Task {
            do {
                try await authRepository.signUp(id: id, password: password)
                XCTFail("Expected notAuthorized error but succeeded")
            } catch AuthError.alreadyExistEmail { // 중복된 이메일인 경우
                expectation.fulfill() // 결과에 충족한 경우
            } catch {
                XCTFail("Expected notAuthorized error but got \(error)")
            }
        }
        
        // Then
        await fulfillment(of: [expectation], timeout: 1.0)
    }
    
    func test_로그인_없는유저일때() async throws {
        let id = "dave2000@gmail.com"
        let password = "aa1072!"
        
        let expectation = XCTestExpectation(description: "존재하지 않는 유저입니다!")
        
        // When
        Task {
            do {
                try await authRepository.signUp(id: id, password: password)
                XCTFail("Expected userNotFound error but succeeded")
            } catch AuthError.userNotFound { // 중복된 이메일인 경우
                expectation.fulfill() // 결과에 충족한 경우
            } catch {
                XCTFail("Expected userNotFound error but got \(error)")
            }
        }
        
        // Then
        await fulfillment(of: [expectation], timeout: 1.0)
    }
}
