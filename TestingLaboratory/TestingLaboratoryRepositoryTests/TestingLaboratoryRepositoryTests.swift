//
//  TestingLaboratoryRepositoryTests.swift
//  TestingLaboratoryRepositoryTests
//
//  Created by 류희재 on 7/1/24.
//

import XCTest
@testable import TestingLaboratory

final class AuthRepositoryTests: XCTestCase {
    
    var sut: AuthRepository!
    var stub: AuthRemoteServiceStub!

    override func setUpWithError() throws {
        stub = .init()
        sut = DefaultAuthRepository(authService: stub)
    }

    override func tearDownWithError() throws {
        stub = nil
        sut = nil
    }
    
}

//MARK: - SignUp
extension AuthRepositoryTests {
    func testSignUp_Success() async throws {
        // given
        stub.signUpResponse = .init(statusCode: 200)
        
        // when
        try await sut.signUp(id: "test@example.com", password: "Password123!")
        
        // then
        // No assertion needed for success case
    }
    
    func testSignUp_AlreadyExistEmail() async throws {
        // given
        stub.signUpResponse = .init(statusCode: 4001)
        
        // when
        do {
            try await sut.signUp(id: "existing@example.com", password: "Password123!")
            XCTFail("Expected error AuthError.alreadyExistEmail not thrown")
        } catch {
            // then
            XCTAssertTrue(error is AuthError)
            XCTAssertEqual(error as? AuthError, AuthError.alreadyExistEmail)
        }
    }
    
    func testSignUp_OtherErrors() async throws {
        // given
        stub.signUpError = NSError(domain: "MockError", code: 500, userInfo: nil)
        
        // when
        do {
            try await sut.signUp(id: "test@example.com", password: "Password123!")
            XCTFail("Expected error AuthError.unknown not thrown")
        } catch {
            // then
        }
    }
}

//MARK: - SignIn
extension AuthRepositoryTests {
        
        func testSignIn_Success() async throws {
            // given
            stub.signInResponse = .init(statusCode: 200)
            
            // when
            try await sut.signIn(id: "test@example.com", password: "Password123!")
            
            // then
            // No assertion needed for success case
        }
        
        func testSignIn_UserNotFound() async throws {
            // given
            stub.signInResponse = .init(statusCode: 404)
            
            // when
            do {
                try await sut.signIn(id: "nonexisting@example.com", password: "Password123!")
                XCTFail("Expected error AuthError.userNotFound not thrown")
            } catch {
                // then
                XCTAssertTrue(error is AuthError)
                XCTAssertEqual(error as? AuthError, AuthError.userNotFound)
            }
        }
        
        func testSignIn_NotAuthorized() async throws {
            // given
            stub.signInResponse = .init(statusCode: 401)
            
            // when
            do {
                try await sut.signIn(id: "test@example.com", password: "WrongPassword123!")
                XCTFail("Expected error AuthError.notAuthorized not thrown")
            } catch {
                // then
                XCTAssertTrue(error is AuthError)
                XCTAssertEqual(error as? AuthError, AuthError.notAuthorized)
            }
        }
        
        func testSignIn_OtherErrors() async throws {
            // given
            stub.signInError = NSError(domain: "MockError", code: 500, userInfo: nil)
            
            // when
            do {
                try await sut.signIn(id: "test@example.com", password: "Password123!")
                XCTFail("Expected error AuthError.unknown not thrown")
            } catch {
                // then
            }
        }
}
