//
//  TestingLaboratoryRepositoryTests.swift
//  TestingLaboratoryRepositoryTests
//
//  Created by 류희재 on 7/1/24.
//

import XCTest
@testable import TestingLaboratory

final class TestingLaboratoryRepositoryTests: XCTestCase {

    private var mockAuthService: AuthService!
    private var authRepository: AuthRepository!
    
    override func setUpWithError() throws {
//        mockAuthService = MockAuthService()
        authRepository = DefaultAuthRepository(
            authService: self.mockAuthService
        )
        
    }

    override func tearDownWithError() throws {
        self.mockAuthService = nil
        self.authRepository = nil
    }
    
    func test_회원가입_성공했을때() throws {
        
    }
    
    func test_회원가입_중복이메일일때() throws {
        
    }
    
    func test_로그인_성공했을때() throws {
        
    }
    
    func test_로그인_not_Authorized() throws {
        
    }
    
    func test_로그인_없는유저일때() throws {
        
    }
}
