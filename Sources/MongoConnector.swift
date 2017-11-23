//
//  MongoConnector.swift
//  GraphQL-Server
//
//  Created by Rumata on 11/10/17.
//
//

import Foundation
import MongoDBStORM
import StORM
import MongoDB

private let security = SecurityDataReader()!

class MongoConnector {

  init() {
    MongoDBConnection.host = security.mongoHost
    MongoDBConnection.database = security.databaseName
  }

  func getEvents(after id: String?, limit: Int) throws -> Page {
    var event = HistoricalEvent()
    let cursor = StORMCursor(limit: limit, offset: 0)
    let query: [String: Any]
    if let id = id {
      let oid = BSON.OID(id)
      query = ["_id": ["$lt": oid]]
    } else {
      try event.find()
      guard let lastEvent = event.rows().last else {
        return Page(items: [], cursor: nil, totalCount: 0)
      }
      query = ["_id": ["$lte": BSON.OID(lastEvent.id)]]
    }

    event = HistoricalEvent()
    try event.find(query, cursor: cursor)
    let events: [HistoricalEvent] = event.rows()

    return Page(items: events, cursor: events.last?.id, totalCount: 0)
  }

  func getHistoricalEvent(id: String) -> HistoricalEvent? {
    do {
      let event = HistoricalEvent()
      try event.get(id)
      return event
    } catch let error {
      print(error)
      return nil
    }
  }

  func addHistoricalEvent(input: HistoricalEventInput) throws -> HistoricalEvent {
    let event = HistoricalEvent()
    event.name = input.name
    event.date = input.date
    event.description = input.description
    event.type = input.type
    try event.save()

    return event
  }

  func updateHistoricalEvent(input: HistoricalEventInput) throws -> HistoricalEvent {
    let event = HistoricalEvent()
    try event.get(input.id!)
    event.name = input.name
    event.date = input.date
    event.description = input.description
    event.type = input.type
    try event.save()

    return event
  }

  func deleteHistoricalEvent(id: String) throws -> HistoricalEvent {
    let event = HistoricalEvent()
    try event.get(id)
    try event.delete()

    return event
  }
  
}
