//
//  GetRates.swift
//  OANDA API Test App
//
//  Created by Timofei Sopin on 2018-07-18.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import Foundation

struct GetRates: Codable {
  
  let meta: Meta?
  let quotes: [Quotes]?
  
  enum CodingKeys: String, CodingKey {
    case meta = "meta"
    case quotes = "quotes"
  }
}
