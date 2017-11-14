//
//  SecurityDataReader.swift
//  GraphQL-Server
//
//  Created by Rumata on 11/14/17.
//
//

import Foundation

struct SecurityDataReader {
  
  let mongoHost: String
  let databaseName: String
  
  init?() {
    guard
      let path = Bundle.main.path(forResource: "Security", ofType: "plist"),
      let dict = NSDictionary(contentsOfFile: path) as? [String: String] else
    {
        return nil
    }
    
    mongoHost = dict["mongo_host"]!
    databaseName = dict["database"]!
  }
  
}
