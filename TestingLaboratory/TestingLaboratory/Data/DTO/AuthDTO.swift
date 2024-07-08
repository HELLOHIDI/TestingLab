//
//  AuthDTO.swift
//  TestingLaboratory
//
//  Created by 류희재 on 6/29/24.
//

import Foundation

// SignUp
struct SignUpRequest: Encodable {
    let id: String
    let pw: String
}

struct SignUpResponse: Decodable, Equatable {
    let statusCode: Int
}

// SignIn
struct SignInRequest: Encodable {
    let id: String
    let pw: String
}

struct SignInResponse: Decodable {
    let statusCode: Int
    
    init(statusCode: Int) {
        self.statusCode = statusCode
    }
}
