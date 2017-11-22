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

  static func addMutations(for schema: SchemaBuilder<NoRoot, RequestContext>) throws {
    try schema.mutation { builder in
      try createEvent(with: builder)
      try updateEvent(with: builder)
      try deleteEvent(with: builder)
    }
  }

  private struct HistoricalEventInputArguments : Arguments {
    let input: HistoricalEventInput
    static let descriptions = ["input": "content of the historical event"]
  }

  private static func createEvent(with builder: ObjectTypeBuilder<NoRoot, RequestContext, NoRoot>) throws {
    try builder.field(name: "createEvent", type: HistoricalEvent.self) { (_, arguments: HistoricalEventInputArguments, context, _) in
      try context.mongo.addHistoricalEvent(input: arguments.input)
    }
  }

  private static func updateEvent(with builder: ObjectTypeBuilder<NoRoot, RequestContext, NoRoot>) throws {
    try builder.field(name: "updateEvent", type: HistoricalEvent.self) { (_, arguments: HistoricalEventInputArguments, context, _) in
      try context.mongo.updateHistoricalEvent(input: arguments.input)
    }
  }

  struct HistoricalEventDeleteArguments : Arguments {
    let id: String
    static let descriptions = ["id": "id of the historical event"]
  }

  private static func deleteEvent(with builder: ObjectTypeBuilder<NoRoot, RequestContext, NoRoot>) throws {
    try builder.field(name: "deleteEvent", type: HistoricalEvent.self) { (_, arguments: HistoricalEventDeleteArguments, context, _) in
      try context.mongo.deleteHistoricalEvent(id: arguments.id)
    }
  }

}
