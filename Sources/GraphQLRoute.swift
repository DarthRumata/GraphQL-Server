//
//  GraphQLRoute.swift
//  GraphQL-Server
//
//  Created by Rumata on 11/8/17.
//
//

import PerfectHTTP
import PerfectRequestLogger
import PerfectLib

let schema = SchemaProvider().schema

let graphRoute = Route(methods: [.get, .post], uri: "/graphql") { (request, response) in
  defer {
    response.completed()
  }

  let query: String?
  if request.method == .post {
    if let body = request.postBodyString, let json = try? body.jsonDecode() as? [String: Any] {
      query = json?["query"] as? String
    } else {
      query = nil
    }
  } else {
    query = request.queryParams.first?.1
  }

  guard let safeQuery = query else {
    response.status = HTTPResponseStatus.badRequest
    return
  }

  let result = try! schema.execute(request: safeQuery)

  response.setHeader(.contentType, value: "application/json")
  response.appendBody(string: "\(result)")
}
