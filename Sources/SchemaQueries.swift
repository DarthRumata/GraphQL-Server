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
    try allEvents(with: schema)
  }

  private static func allEvents(with schema: SchemaBuilder<NoRoot, NoContext>) throws {
    try schema.query { query in
      try query.field(name: "allEvents", type: [HistoricalEvent].self) { _, _, _, _ in
        getEvents()
      }
    }
  }

}


private func getEvents() -> [HistoricalEvent] {
  return [
    HistoricalEvent(
      name: "First man born",
      date: "10000-01-01 BC".toDate(),
      description: "First man was born",
      type: .common
    ),
    HistoricalEvent(
      name: "Antoine de Saint-Exupéry",
      date: "1900-06-29 AD".toDate(),
      description: "Antoine Marie Jean-Baptiste Roger, comte de Saint-Exupéry was born",
      type: .greatPerson
    ),
    HistoricalEvent(
      name: "The Battle of Pavia",
      date: "1525-02-24 AD".toDate(),
      description: "Decisive engagement of the Italian War ",
      type: .battle
    )
  ]
}

