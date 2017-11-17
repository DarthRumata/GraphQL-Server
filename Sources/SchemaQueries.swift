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
  
  static func addQueries(for schema: SchemaBuilder<NoRoot, NoContext>) throws {
    try schema.query { query in
      try allEvents(with: query)
      try historicalEvent(with: query)
    }
  }
  
  private static func allEvents(with query: ObjectTypeBuilder<NoRoot, NoContext, NoRoot>) throws {
    try query.field(name: "allEvents", type: [HistoricalEvent].self) { _, _, _, _ in
      MongoConnector.shared.getAllEvents()
    }
  }
  
  struct HistoricalEventArguments : Arguments {
    let id: String
    static let descriptions = ["id": "id of the historical event"]
  }
  
  private static func historicalEvent(with query: ObjectTypeBuilder<NoRoot, NoContext, NoRoot>) throws {
    try query.field(name: "historicalEvent") { (_, arguments: HistoricalEventArguments, _, _) in
      MongoConnector.shared.getHistoricalEvent(id: arguments.id)
    }
  }
  
}

//HistoricalEvent(
//  name: "The Battle of Pavia",
//  date: "1525-02-24 AD".toDate(),
//  description: "Decisive engagement of the Italian War ",
//  type: .battle
//)

