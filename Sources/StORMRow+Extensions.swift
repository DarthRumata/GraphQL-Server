//
//  StORMRow+Extensions.swift
//  GraphQL-Server
//
//  Created by Rumata on 11/10/17.
//
//

import Foundation
import StORM

extension StORMRow {

  subscript(key: String) -> Any? {
    let value = data[key]
    guard let innerType = value as? [String: Any] else {
      return value
    }

    guard let (type, typeValue) = innerType.first else {
      return nil
    }

    switch type {
    case "$date":
      guard let seconds = typeValue as? Int else {
        return nil
      }
      let timeIntervalSince1970 = TimeInterval(seconds / 1000)
      return Date(timeIntervalSince1970: timeIntervalSince1970)

    case "$oid":
      return typeValue as? String

    default:
      return nil
    }
  }

  func get<T>(byKey key: String) -> T? {
    return self[key] as? T
  }

}


precedencegroup ParseTypePrecedence {
  higherThan: MultiplicationPrecedence
  associativity: left
}

infix operator ~>: ParseTypePrecedence

func ~><T>(left: StORMRow, right: String) -> T? {
  return left.get(byKey: right)
}
