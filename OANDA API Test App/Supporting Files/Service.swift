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
  
  private let API_KEY = "KZpDof7EejOzKl9SuvU9OSgO"
  
  //Getting exhange rate for two currencies at a specified point in time
  func getRateFromAPI(base: String, quote: String, date: String, handler: @escaping (_ returnedRate: String) -> ()) {
    
    guard let API_URL = URL(string: "https://www.oanda.com/rates/api/v2/rates/spot.json?base=\(base)&quote=\(quote)&date_time=\(date)&api_key=\(API_KEY)")  else { return }
    
    URLSession.shared.dataTask(with: API_URL) { (data, response, error) in
      guard let data = data else { return }
      
      var returnedRate = String()
      
      do {
        
        let decoder = JSONDecoder()
        let receivedData = try decoder.decode(GetRates.self, from: data)
        
        returnedRate = receivedData.quotes![0].midpoint!
        
        handler(returnedRate)
        
      } catch let error {
        print("JSON Parsing Error", error)
      }
      }.resume()
  }
  
  //Getting list of currencies from API
  func getListOfCurrencies(handler: @escaping (_ returnedCurrencies: [Currencies]) -> ()) {
    
    guard let API_URL = URL(string: "https://web-services.oanda.com/rates/api/v2/currencies.json?api_key=\(API_KEY)")  else { return }
    
    URLSession.shared.dataTask(with: API_URL) { (data, response, error) in
      guard let data = data else { return }
      
      var returnedCurrencies = [Currencies]()
      
      do {
        
        let decoder = JSONDecoder()
        let receivedData = try decoder.decode(GetCurrencies.self, from: data)
        
        for currency in receivedData.currencies! {
          returnedCurrencies.append(currency)
        }
        
        handler(returnedCurrencies)
        
      } catch let error {
        print("JSON Parsing Error", error)
      }
      }.resume()
  }
}
