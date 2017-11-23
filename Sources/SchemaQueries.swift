//
//  SchemaQueries.swift
//  GraphQL-Server
//
//  Created by Rumata on 11/9/17.
//
//

import GraphQL
import Graphiti

enum SchemaQueries {
  
  static func addQueries(for schema: SchemaBuilder<NoRoot, RequestContext>) throws {
    try schema.query { query in
      try allEvents(with: query)
      try historicalEvent(with: query)
    }
  }

  struct HistoricalPageArguments : Arguments {
    let cursor: String?
    let limit: Int
    static let descriptions = ["cursor": "id of last historical event at page", "limit": "page size"]
  }

  private static func allEvents(with query: ObjectTypeBuilder<NoRoot, RequestContext, NoRoot>) throws {
    try query.field(name: "allEvents", type: Page.self) { (_, arguments: HistoricalPageArguments, context, _) in
      try context.mongo.getEvents(after: arguments.cursor, limit: arguments.limit)
    }
  }
  
  struct HistoricalEventArguments : Arguments {
    let id: String
    static let descriptions = ["id": "id of the historical event"]
  }
  
  private static func historicalEvent(with query: ObjectTypeBuilder<NoRoot, RequestContext, NoRoot>) throws {
    try query.field(name: "historicalEvent") { (_, arguments: HistoricalEventArguments, context, _) in
      context.mongo.getHistoricalEvent(id: arguments.id)
    }
  }
  
}

//HistoricalEvent(
//  name: "The Battle of Pavia",
//  date: "1525-02-24 AD".toDate(),
//  description: "Decisive engagement of the Italian War ",
//  type: .battle
//)

