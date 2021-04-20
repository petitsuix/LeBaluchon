//
//  CurrencyViewController.swift
//  LeBaluchon
//
//  Created by Richardier on 13/04/2021.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    @IBOutlet weak var euroTextField: UITextField! {
        didSet { euroTextField?.addDoneCancelToolbar() }
    }
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var eurToDollarsRate: UILabel!
    
    var fixerApi = APICurrency()
    var resultCurrency: MainCurrencyInfo?
    var conversionResult: String = "$"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchCurrency()
    }
    
    func fetchCurrency() {
        fixerApi.start() { (decodedData, error) in
            print(error ?? "")
            self.resultCurrency = decodedData
            DispatchQueue.main.async { [weak self] in
                self?.updateUI()
            }
        }
    }
    
    func updateUI() {
        guard let currency = resultCurrency else { return }
        guard let usdRate = currency.rates.USD else { return }
        self.eurToDollarsRate.text = "1€ = \(usdRate.shortDigitsIn(4))$"
        resultLabel.layer.masksToBounds = true
        resultLabel.layer.cornerRadius = 5
    }
    @IBAction func convertButton(_ sender: UIButton) {
        guard let currency = resultCurrency,
              let usdRate = currency.rates.USD,
              let euroTextField = euroTextField.text,
              let floatTextField = Float(euroTextField) else { return }
        resultLabel.text = "\(floatTextField * usdRate) $"
    }
}
