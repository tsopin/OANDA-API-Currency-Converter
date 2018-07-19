//
//  Service.swift
//  OANDA API Test App
//
//  Created by Timofei Sopin on 2018-07-18.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import Foundation

class Service {
  
  static let instance = Service()
  
//  var orders = [Meta]()
  
  let API_KEY = "KZpDof7EejOzKl9SuvU9OSgO"

  
  //2017-03-01
  
  func getOrdersFromAPI(base: String, quote: String, date: String, handler: @escaping (_ returnedRate: String) -> ()) {
    
    guard let API_URL = URL(string: "https://www.oanda.com/rates/api/v2/rates/spot.json?base=\(base)&quote=\(quote)&date_time=\(date)&api_key=\(API_KEY)")  else { return }
    
    URLSession.shared.dataTask(with: API_URL) { (data, response, error) in
      guard let data = data else { return }
      
      var returnedRate = String()
      
      do {
        let decoder = JSONDecoder()
        let receivedData = try decoder.decode(GetRates.self, from: data)
        
        returnedRate = receivedData.quotes![0].midpoint!
        
        
//        for i in receivedOrders.quotes![0] {
//          self.orders.append(i)
//        }
        
        handler(returnedRate)
        
      } catch let error {
        print("JSON Error", error)
      }
      }.resume()
  }
}
