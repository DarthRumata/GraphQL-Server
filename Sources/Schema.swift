//
//  Schema.swift
//  GraphQL-Server
//
//  Created by Rumata on 11/8/17.
//
//

import GraphQL
import Graphiti

struct RequestContext {
  let mongo = MongoConnector()
}

struct SchemaProvider {
  let schema: Schema<NoRoot, RequestContext>
  
  init() {
    schema = try! Schema<NoRoot, RequestContext> { schema in
      try SchemaTypes.addTypes(for: schema)
      try SchemaQueries.addQueries(for: schema)
      try SchemaMutations.addMutations(for: schema)
    }
  }

}
