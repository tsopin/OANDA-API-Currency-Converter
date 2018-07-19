//
//  Meta.swift
//  OANDA API Test App
//
//  Created by Timofei Sopin on 2018-07-18.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import Foundation

struct Meta: Codable {
	let effective_params: Effective_params?
	let endpoint: String?
	let request_time: String?
	let skipped_currency_pairs: [String]?

	enum CodingKeys: String, CodingKey {

		case effective_params = "effective_params"
		case endpoint = "endpoint"
		case request_time = "request_time"
		case skipped_currency_pairs = "skipped_currency_pairs"
	}
}
