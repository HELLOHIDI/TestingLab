//
//  MockAuthService.swift
//  TestingLaboratoryRepositoryTests
//
//  Created by 류희재 on 7/1/24.
//

import Foundation

@testable import TestingLaboratory

class AuthRemoteServiceStub: AuthService {
    var signUpResponse: SignUpResponse?
    var signUpError: Error?
    
    
    var signInResponse: SignInResponse?
    var signInError: Error?
    
    func signUp(with request: SignUpRequest) async throws -> SignUpResponse {
        guard signUpError == nil else { throw signUpError! }
        guard let response = signUpResponse else { fatalError("개발자가 response를 설정하지 않았습니다.")}
        return response
    }
    
    func signIn(with request: SignInRequest) async throws -> SignInResponse {
        guard signInError == nil else { throw signInError! }
        guard let response = signInResponse else { fatalError("개발자가 response를 설정하지 않았습니다.")}
        return response
    }
    
    
}
