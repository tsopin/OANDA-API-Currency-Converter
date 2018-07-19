//
//  Effective_params.swift
//  OANDA API Test App
//
//  Created by Timofei Sopin on 2018-07-18.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import Foundation

struct Effective_params : Codable {
	let data_set : String?
	let base_currencies : [String]?
	let quote_currencies : [String]?
	let date_time : String?

	enum CodingKeys: String, CodingKey {

		case data_set = "data_set"
		case base_currencies = "base_currencies"
		case quote_currencies = "quote_currencies"
		case date_time = "date_time"
	}
}
