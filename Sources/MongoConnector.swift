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

  private lazy var historicalEventCollection: HistoricalEvent = HistoricalEvent()

  init() {
    MongoDBConnection.host = security.mongoHost
    MongoDBConnection.database = security.databaseName
  }

  func getAllEvents() -> [HistoricalEvent] {
    do {
      try historicalEventCollection.find()
      return historicalEventCollection.rows()
    } catch let error {
      print(error)
      return []
    }
  }
  
}
