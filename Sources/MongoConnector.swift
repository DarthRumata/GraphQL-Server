//
//  MongoConnector.swift
//  GraphQL-Server
//
//  Created by Rumata on 11/10/17.
//
//

import Foundation
import MongoDBStORM

class MongoConnector {

  static let shared = MongoConnector()

  private lazy var historicalEventCollection: HistoricalEvent = HistoricalEvent()

  init() {
    MongoDBConnection.host = "admin:TYU11bnm@cluster0-shard-00-00-c81ud.mongodb.net:27017,cluster0-shard-00-01-c81ud.mongodb.net:27017,cluster0-shard-00-02-c81ud.mongodb.net:27017/test?ssl=true&replicaSet=Cluster0-shard-0&authSource=admin"
    MongoDBConnection.authdb = "admin"
    MongoDBConnection.authmode = .standard
    MongoDBConnection.username = "admin"
    MongoDBConnection.database = "demo"
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
