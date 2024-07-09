//
//  URLSessionDataTaskProtocol.swift
//  TestingLaboratory
//
//  Created by 류희재 on 7/8/24.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
