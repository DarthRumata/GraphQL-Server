//
//  Page.swift
//  GraphQL-Server
//
//  Created by Rumata on 11/22/17.
//
//

import Foundation

struct Page {

  let items: [HistoricalEvent]
  let cursor: String?
  let totalCount: Int

}
