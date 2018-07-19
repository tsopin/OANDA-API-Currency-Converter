//
//  ViewController.swift
//  OANDA API Test App
//
//  Created by Timofei Sopin on 2018-07-18.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

class GetRatesVC: UIViewController {
  
  @IBOutlet weak var rateLabel: UILabel!
  @IBOutlet weak var basePicker: UIPickerView!
  @IBOutlet weak var quotePicker: UIPickerView!
  @IBOutlet weak var datePicker: UIDatePicker!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  let service = Service.instance
  var currenciesArray = [Currencies]()
  
  var base = String()
  var quote = String()
  let date = "2017-03-01"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    activityIndicator.isHidden = true
    
    basePicker.delegate = self
    basePicker.dataSource = self
    
    quotePicker.delegate = self
    quotePicker.dataSource = self
    
    service.getListOfCurrencies { (returnedCurrencies) in
      self.currenciesArray = returnedCurrencies
      DispatchQueue.main.async {
        self.basePicker.reloadAllComponents()
        self.quotePicker.reloadAllComponents()
      }
    }
    print("CURRENCIES \(currenciesArray)")
  }
  
  
  @IBAction func getRatedButtonPressed(_ sender: Any) {
    activityIndicator.isHidden = false
    activityIndicator.startAnimating()
    
    service.getOrdersFromAPI(base: base, quote: quote, date: date) { (rates) in
      DispatchQueue.main.async {
        self.rateLabel.text = rates
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
      }
    }
  }
}

extension GetRatesVC: UIPickerViewDelegate, UIPickerViewDataSource {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return currenciesArray.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return currenciesArray[row].code
  }
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if pickerView == basePicker {
      base = currenciesArray[row].code!
    } else if pickerView == quotePicker {
      quote = currenciesArray[row].code!
    }
    
  }
  
}

