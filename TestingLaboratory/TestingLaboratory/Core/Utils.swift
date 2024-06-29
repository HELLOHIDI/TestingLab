//
//  Utils.swift
//  TestingLaboratory
//
//  Created by 류희재 on 6/29/24.
//

import Foundation

protocol Regexable {
  var regex: String { get }
  func validate(_ target: String) -> Bool
}

extension Regexable {
  func validate(_ target: String) -> Bool {
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    return predicate.evaluate(with: target)
  }
}

enum Regex {
  case email
  case password
}

extension Regex: Regexable {
  var regex: String {
    switch self {
      
    case .email:
      "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    case .password:
      "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,50}"
    }
  }
}
