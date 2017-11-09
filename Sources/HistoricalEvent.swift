//
//  HistoricalEvent.swift
//  GraphQL-Server
//
//  Created by Rumata on 11/8/17.
//
//

import Foundation
import GraphQL
import Graphiti

enum HistoricalEventType: String {
  case common = "common"
  case greatPerson = "greatPerson"
  case battle = "battle"

  init(map: Map) throws {
    guard let value = map.string, let type = HistoricalEventType(rawValue: value) else {
      throw MapError.incompatibleType
    }

    self = type
  }

  func asMap() throws -> Map {
    return rawValue.map
  }
}

struct HistoricalEvent {
  let name: String
  let date: String
  let description: String
  let type: HistoricalEventType
}
