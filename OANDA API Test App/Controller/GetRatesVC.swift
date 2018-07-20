//
//  ViewController.swift
//  OANDA API Test App
//
//  Created by Timofei Sopin on 2018-07-18.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

class GetRatesVC: UIViewController {
  
  let service = Service.instance
  
  @IBOutlet private weak var rateLabel: UILabel!
  @IBOutlet private weak var baseLabel: UILabel!
  @IBOutlet private weak var quoteLabel: UILabel!
  @IBOutlet private weak var basePicker: UIPickerView!
  @IBOutlet private weak var quotePicker: UIPickerView!
  @IBOutlet private weak var datePicker: UIDatePicker!
  @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet private weak var getRateButton: UIButton!
  
  private let date = Date()
  private let formatter = DateFormatter()
  
  private var currenciesArray = [Currencies]()
  private var quoteDate = String()
  private var base = String()
  private var quote = String()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    formatter.dateFormat = "YYYY-MM-dd"
    
    getRateButton.layer.cornerRadius = 8
    activityIndicator.isHidden = true
    getRateButton.isHidden = true
    
    basePicker.delegate = self
    basePicker.dataSource = self
    basePicker.isUserInteractionEnabled = false
    
    quotePicker.delegate = self
    quotePicker.dataSource = self
    quotePicker.isUserInteractionEnabled = false
    
    datePicker.maximumDate = date
    datePicker.isUserInteractionEnabled = false
    quoteDate = formatter.string(from: date)
    
    service.getListOfCurrencies { (returnedCurrencies) in
      
      self.currenciesArray = returnedCurrencies
      self.base = self.currenciesArray[0].code!
      self.quote = self.currenciesArray[0].code!
      
      DispatchQueue.main.async {
        self.baseLabel.text = self.currenciesArray[0].description!
        self.quoteLabel.text = self.currenciesArray[0].description!
        self.basePicker.reloadAllComponents()
        self.quotePicker.reloadAllComponents()
        
        self.basePicker.isUserInteractionEnabled = true
        self.quotePicker.isUserInteractionEnabled = true
        self.datePicker.isUserInteractionEnabled = true
        
        self.getRateButton.isHidden = false
      }
    }
  }
  
  @IBAction private func getRateButtonPressed(_ sender: Any) {
    activityIndicator.isHidden = false
    activityIndicator.startAnimating()
    
    service.getRateFromAPI(base: base, quote: quote, date: quoteDate) { (rates) in
      DispatchQueue.main.async {
        self.rateLabel.text = rates
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
      }
    }
  }
  
  @IBAction private func datePicker(_ sender: Any) {
    quoteDate = formatter.string(from: datePicker.date)
  }
}

//MARK: Picker Methods
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
      baseLabel.text = currenciesArray[row].description!
    } else if pickerView == quotePicker {
      quote = currenciesArray[row].code!
      quoteLabel.text = currenciesArray[row].description!
    }
  }
}

