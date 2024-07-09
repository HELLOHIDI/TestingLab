//
//  Coffee.swift
//  TestingLaboratory
//
//  Created by 류희재 on 7/8/24.
//

import Foundation

struct Coffee: Decodable {
    let title: String
    let description: String
    let ingredients: [String]
    let id: Int
}
