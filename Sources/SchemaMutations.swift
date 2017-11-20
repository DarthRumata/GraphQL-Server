//
//  SchemaMutations.swift
//  GraphQL-Server
//
//  Created by Rumata on 11/16/17.
//
//

import Foundation
import GraphQL
import Graphiti

enum SchemaMutations {

  static func addMutations(for schema: SchemaBuilder<NoRoot, NoContext>) throws {
    try schema.mutation { builder in
      try createEvent(with: builder)
      try updateEvent(with: builder)
    }
  }

  private struct HistoricalEventInputArguments : Arguments {
    let input: HistoricalEventInput
    static let descriptions = ["input": "content of the historical event"]
  }

  private static func createEvent(with builder: ObjectTypeBuilder<NoRoot, NoContext, NoRoot>) throws {
    try builder.field(name: "createEvent", type: HistoricalEvent.self) { (_, arguments: HistoricalEventInputArguments, _, _) in
      try MongoConnector.shared.addHistoricalEvent(input: arguments.input)
    }
  }

  private static func updateEvent(with builder: ObjectTypeBuilder<NoRoot, NoContext, NoRoot>) throws {
    try builder.field(name: "updateEvent", type: HistoricalEvent.self) { (_, arguments: HistoricalEventInputArguments, _, _) in
      try MongoConnector.shared.updateHistoricalEvent(input: arguments.input)
    }
  }

}
