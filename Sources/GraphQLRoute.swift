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
import GraphQL
import Foundation

private let schema = SchemaProvider().schema
private let context = RequestContext()

let graphRoute = Route(method: .post, uri: "/graphql") { (request, response) in
  defer {
    response.completed()
  }
  
  let query: String?
  var variables: [String: Map]?
  if let body = request.postBodyString, let json = try? body.jsonDecode() as? [String: Any] {
    query = json?["query"] as? String
    let variablesMap = try? map(from: json?["variables"])
    if let map = variablesMap, case .dictionary(let dict) = map {
      variables = dict
    }
  } else {
    query = nil
  }

  guard let safeQuery = query else {
    response.status = HTTPResponseStatus.badRequest
    return
  }
  
  do {
    let result = try schema.execute(request: safeQuery, context: context, variables: variables ?? [:])
    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: "\(result)")
  } catch let error {
    response.status = HTTPResponseStatus.internalServerError
    print(error)
  }
}
