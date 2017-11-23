//
//  HistoricalEvent.swift
//  GraphQL-Server
//
//  Created by Rumata on 11/8/17.
//
//

import Foundation
import StORM
import MongoDBStORM
import MongoDB

enum HistoricalEventType: String {
  case common = "common"
  case greatPerson = "greatPerson"
  case battle = "battle"
}

class HistoricalEvent: MongoDBStORM {

  var id: String = ""
  var name: String = ""
  var date: Date = Date()
  var type: HistoricalEventType = .common
  var description: String?

  override init() {
    super.init()

    _collection = "historical_events"
  }

  override func to(_ this: StORMRow) {
    id = (this~>"_id") ?? id
    name = (this~>"name") ?? name
    date = (this~>"date") ?? date
    description = (this~>"description")
    let typeString = (this~>"type") ?? ""
    type = HistoricalEventType(rawValue: typeString) ?? type
  }

  func rows() -> [HistoricalEvent] {
    return results.rows.map {
      let event = HistoricalEvent()
      event.to($0)

      return event
    }
  }

  override func modifyValue(_ v: Any, forKey k: String) -> Any {
    if k == "type" {
      return type.rawValue
    } else if k == "id" {
      return (v as? String) == "" ? v : BSON.OID(id)
    } else {
      return super.modifyValue(v, forKey: k)
    }
  }

}
