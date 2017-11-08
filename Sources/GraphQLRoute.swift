//
//  GraphQLRoute.swift
//  GraphQL-Server
//
//  Created by Rumata on 11/8/17.
//
//

import PerfectHTTP
import PerfectHTTPServer

let schema = SchemaProvider().schema

let graphRoute = Route(method: .get, uri: "/graphql") { (request, response) in
  let query = request.queryParams.first!.1
  let result = try! schema.execute(request: query)

  response.setHeader(.contentType, value: "application/json")
  response.appendBody(string: "\(result)")
  response.completed()
}
