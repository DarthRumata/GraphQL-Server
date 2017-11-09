//
//  SchemaTypes.swift
//  GraphQL-Server
//
//  Created by Rumata on 11/9/17.
//
//

import GraphQL
import Graphiti

extension HistoricalEventType: InputType, OutputType {}
extension HistoricalEvent: OutputType {}

enum SchemaTypes {

  static func addTypes(for schema: SchemaBuilder<NoRoot, NoContext>) throws {
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

}
