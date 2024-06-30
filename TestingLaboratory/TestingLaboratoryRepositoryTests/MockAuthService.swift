//
//  MockAuthService.swift
//  TestingLaboratoryRepositoryTests
//
//  Created by 류희재 on 7/1/24.
//

import Foundation

final class MockAuthService: AuthService {
    private let mockExistedEmail = "fbgmlwo123@naver.com"
    private let mockMemberInfo = SignInRequest(id: "dave2000@gmail.com", pw: "aa1072!")
    
    func signUp(with request: SignUpRequest) async throws -> SignUpResponse {
        if request.id == mockExistedEmail { return SignUpResponse(statusCode: 4001) }
        else { return SignUpResponse(statusCode: 200) }
    }
    
    func signIn(with request: SignInRequest) async throws -> SignInResponse {
        if request.id != mockMemberInfo.id {
            return SignInResponse(statusCode: 404)
        } else {
            if request.pw != mockMemberInfo.pw {
                return SignInResponse(statusCode: 401)
            } else {
                return SignInResponse(statusCode: 200)
            }
        }
    }
}
