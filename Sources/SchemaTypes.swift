//
//  SchemaTypes.swift
//  GraphQL-Server
//
//  Created by Rumata on 11/9/17.
//
//

import GraphQL
import Graphiti
import Foundation

extension HistoricalEventType: InputType, OutputType {

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
extension HistoricalEvent: OutputType {}
extension Date: OutputType, InputType {}

private let dateFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateFormat = "yyyy-MM-dd GG"
  formatter.timeZone = TimeZone(abbreviation: "UTC")
  return formatter
}()

enum SchemaTypes {

  static func addTypes(for schema: SchemaBuilder<NoRoot, NoContext>) throws {
    try dateScalar(with: schema)
    try historicalEventTypeEnum(with: schema)
    try historicalEventObject(with: schema)
  }

  private static func historicalEventObject(with schema: SchemaBuilder<NoRoot, NoContext>) throws {
    try schema.object(type: HistoricalEvent.self) { event in
      try event.exportFields()
    }
  }

  private static func historicalEventTypeEnum(with schema: SchemaBuilder<NoRoot, NoContext>) throws {
    try schema.enum(type: HistoricalEventType.self) { type in
      try type.value(name: "COMMON", value: .common)
      try type.value(name: "GREAT_PERSON", value: .greatPerson)
      try type.value(name: "BATTLE", value: .battle)
    }
  }

  private static func dateScalar(with schema: SchemaBuilder<NoRoot, NoContext>) throws {
    try schema.scalar(name: "dateISO", type: Date.self, build: { (builder) in
      builder.serialize { (date) -> Map in
        let dateString = dateFormatter.string(from: date)

        return try map(from: dateString)
      }
      builder.parseValue { (map) -> Map in
        guard let dateString = map.string, let date = dateFormatter.date(from: dateString) else {
          throw MapError.incompatibleType
        }

        return try date.asMap()
      }
      builder.parseLiteral { (ast) -> Map in
        guard let ast = ast as? StringValue else {
          return .null
        }

        return ast.value.map
      }
    })
  }

}

extension String {

  func toDate() -> Date {
    return dateFormatter.date(from: self)!
  }

}