//
//  Quotes.swift
//  OANDA API Test App
//
//  Created by Timofei Sopin on 2018-07-18.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import Foundation

struct Quotes : Codable {
	let base_currency : String?
	let quote_currency : String?
	let date_time : String?
	let bid : String?
	let ask : String?
	let midpoint : String?

	enum CodingKeys: String, CodingKey {

		case base_currency = "base_currency"
		case quote_currency = "quote_currency"
		case date_time = "date_time"
		case bid = "bid"
		case ask = "ask"
		case midpoint = "midpoint"
	}
}
