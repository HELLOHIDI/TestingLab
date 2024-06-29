//
//  AuthService.swift
//  TestingLaboratory
//
//  Created by 류희재 on 6/29/24.
//

import Foundation

protocol AuthService {
    func signUp(with request: SignUpRequest) async throws -> SignUpResponse
    func signIn(with request: SignInRequest) async throws -> SignInResponse
}

final class DefaultAuthService: AuthService {
    private var provider: Provider
    
    init(provider: Provider) {
        self.provider = provider
    }
    
    func signUp(with request: SignUpRequest) async throws -> SignUpResponse {
        return  try await provider.request(
            with: APIEndpoints.signUp(with: request),
            dto: SignUpResponse.self
        )
    }
    
    func signIn(with request: SignInRequest) async throws -> SignInResponse {
        return  try await provider.request(
            with: APIEndpoints.signIn(with: request),
            dto: SignInResponse.self
        )
    }
    
    
}









