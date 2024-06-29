//
//  APIEndPoints.swift
//  TestingLaboratory
//
//  Created by 류희재 on 6/30/24.
//

struct APIEndpoints {
    static func signUp(with signUpRequest: SignUpRequest) -> Endpoint<SignUpResponse> {
        return Endpoint(baseURL: "https://naver.com",
                        path: "/signUp",
                        method: .post,
                        body: signUpRequest
        )
    }
    
    static func signIn(with signInRequest: SignInRequest) -> Endpoint<SignInResponse> {
        return Endpoint(baseURL: "https://naver.com",
                        path: "/signIn",
                        method: .post,
                        body: signInRequest
        )
    }
}
