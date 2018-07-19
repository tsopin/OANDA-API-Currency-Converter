//
//  GetCurrencies.swift
//  OANDA API Test App
//
//  Created by Timofei Sopin on 2018-07-18.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//


import Foundation

struct GetCurrencies : Codable {
  
	let currencies : [Currencies]?

	enum CodingKeys: String, CodingKey {
		case currencies = "currencies"
	}
}
