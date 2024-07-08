//
//  MockAuthRepository.swift
//  TestingLaboratoryTests
//
//  Created by 류희재 on 7/1/24.
//

import Foundation

final class MockAuthRepository: AuthRepository {
    func signUp(id: String, password: String) async throws {
        return Void()
    }
    
    func signIn(id: String, password: String) async throws {
        return Void()
    }
}
