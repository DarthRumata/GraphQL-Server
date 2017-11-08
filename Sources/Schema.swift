//
//  Schema.swift
//  GraphQL-Server
//
//  Created by Rumata on 11/8/17.
//
//

import GraphQL
import Graphiti

struct SchemaProvider {
  let schema: Schema<NoRoot, NoContext>

  init() {
    schema = try! Schema<NoRoot, NoContext> { schema in
      try schema.object(type: HistoricalEvent.self) { event in
        try event.exportFields()
      }
      try schema.query { query in
        try query.field(name: "allEvents", type: [HistoricalEvent].self) { _, _, _, _ in
          getEvents()
        }
      }
    }
  }
}

private func getEvents() -> [HistoricalEvent] {
  return [HistoricalEvent(name: "First man born", date: "10 mln BC", description: "First man is born")]
}
