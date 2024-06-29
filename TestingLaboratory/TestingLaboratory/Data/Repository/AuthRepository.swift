//
//  AuthRepository.swift
//  TestingLaboratory
//
//  Created by 류희재 on 6/29/24.
//

import Foundation

protocol AuthRepository {
    func signUp(id: String, password: String) async throws
    func signIn(id: String, password: String) async throws
}

final class DefaultAuthRepository: AuthRepository {
    
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func signUp(id: String, password: String) async throws {
        let request = SignUpRequest(id: id, pw: password)
        
        let response = try await authService.signUp(with: .init(id: id, pw: password))
        
        guard response.statusCode != 4001 else { throw AuthError.alreadyExistEmail }
        guard (200..<400).contains(response.statusCode) else { throw AuthError.unknown }
        
    }
    
    func signIn(id: String, password: String) async throws {
        
        let response = try await authService.signIn(with: .init(id: id, pw: password))
        
        guard response.statusCode != 401 else { throw AuthError.notAuthorized }
        guard response.statusCode != 404 else { throw AuthError.userNotFound }
        guard (200..<400).contains(response.statusCode) else { throw AuthError.unknown }
        
    }
}
