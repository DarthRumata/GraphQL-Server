//
//  GraphQLRoute.swift
//  GraphQL-Server
//
//  Created by Rumata on 11/8/17.
//
//

import PerfectHTTP

let schema = SchemaProvider().schema

let graphRoute = Route(method: .get, uri: "/graphql") { (request, response) in
  let result = try! schema.execute(request: "query GetAllEvents { allEvents { name } }")

  response.setHeader(.contentType, value: "application/json")
  response.appendBody(string: "\(result)")
  response.completed()
}
