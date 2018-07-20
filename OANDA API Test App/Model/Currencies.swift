//
//  Currencies.swift
//  OANDA API Test App
//
//  Created by Timofei Sopin on 2018-07-18.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//


import Foundation

struct Currencies : Codable {
  
  let code : String?
  let description : String?
  
  enum CodingKeys: String, CodingKey {
    case code = "code"
    case description = "description"
  }
}
