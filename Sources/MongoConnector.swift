//
//  MongoConnector.swift
//  GraphQL-Server
//
//  Created by Rumata on 11/10/17.
//
//

import Foundation
import MongoDBStORM

private let security = SecurityDataReader()!

class MongoConnector {

  static let shared = MongoConnector()

  init() {
    MongoDBConnection.host = security.mongoHost
    MongoDBConnection.database = security.databaseName
  }

  func getAllEvents() -> [HistoricalEvent] {
    do {
      let event = HistoricalEvent()
      try event.find()
      return event.rows()
    } catch let error {
      print(error)
      return []
    }
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
    event.id = event.newUUID()
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
  
}
