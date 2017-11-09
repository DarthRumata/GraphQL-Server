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
      try SchemaTypes.addTypes(for: schema)
      try SchemaQueries.addQueries(for: schema)
    }
  }

}
