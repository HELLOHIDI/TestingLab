//
//  EndPoint.swift
//  TestingLaboratory
//
//  Created by 류희재 on 6/30/24.
//

class Endpoint<R>: Requestable {
    typealias Response = R
    
    var baseURL: String
    var path: String
    var method: HttpMethod
    var body: Encodable?
    
    init(baseURL: String, path: String, method: HttpMethod, body: Encodable? = nil) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.body = body
    }
}
