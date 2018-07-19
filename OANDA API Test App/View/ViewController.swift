//
//  ViewController.swift
//  OANDA API Test App
//
//  Created by Timofei Sopin on 2018-07-18.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var rateLabel: UILabel!
  
  let service = Service.instance
  
  let base = "USD"
  let quote = "RUB"
  let date = "2017-03-01"
  
  

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  
  @IBAction func getRatedButtonPressed(_ sender: Any) {
    
    service.getOrdersFromAPI(base: base, quote: quote, date: date) { (rates) in
      DispatchQueue.main.async {
         self.rateLabel.text = rates
      }
     
    }
  }
  


}

