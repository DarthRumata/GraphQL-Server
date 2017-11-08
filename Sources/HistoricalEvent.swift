//
//  HistoricalEvent.swift
//  GraphQL-Server
//
//  Created by Rumata on 11/8/17.
//
//

import Foundation
import GraphQL
import Graphiti

struct HistoricalEvent: OutputType {
  let name: String
  let date: String
  let description: String
}
