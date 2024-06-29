//
//  AuthUseCase.swift
//  TestingLaboratory
//
//  Created by 류희재 on 6/29/24.
//

import Foundation

enum AuthError: Error {
  case alreadyExistEmail
  case invalidEmail
  case invalidPassword
  case userNotFound
  case notAuthorized
  case unknown
}

protocol AuthUseCase {
    func signUp(_ id: String, _ password: String) async throws
    func signIn(_ id: String, _ password: String) async throws
}

class DefaultAuthUseCase: AuthUseCase {
    
    let repository: AuthRepository
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
    
    func signUp(_ id: String, _ password: String) async throws  {
        guard Regex.email.validate(id) else {  throw AuthError.invalidEmail }
        guard Regex.password.validate(password) else {  throw AuthError.invalidPassword }
        return try await repository.signUp(id: id, password: password)
    }
    
    func signIn(_ id: String, _ password: String) async throws {
        guard Regex.email.validate(id) else {  throw AuthError.invalidEmail }
        guard Regex.password.validate(password) else {  throw AuthError.invalidPassword }
        return try await repository.signIn(id: id, password: password)
    }
}
