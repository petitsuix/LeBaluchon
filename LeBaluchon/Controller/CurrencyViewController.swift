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
        fixerApi.fetchCurrencyData { [weak self] (result) in
            switch result {
            case .success(let currencyInfo):
                self?.resultCurrency = currencyInfo
                DispatchQueue.main.async { [weak self] in
                    self?.updateUI()
                }
            case .failure(let error):
                print("error: \(error.errorDescription)") // Afficher UI Alert à la place
            }
        }
        //        fixerApi.fetchCurrencyData() { (decodedData, error) in
        //            print(error ?? "")
        //            self.resultCurrency = decodedData
        //            DispatchQueue.main.async { [weak self] in
        //                self?.updateUI()
        //            }
        //        }
    }
    
    func updateUI() {
        guard let currency = resultCurrency,
              let euroTextField = euroTextField.text,
              let finalEuroTextField = euroTextField.floatValue,
              let floatTextField = Float?(finalEuroTextField),
              let usdRate = currency.rates.USD else { return }
        self.eurToDollarsRate.text = "1€ = \(usdRate.shortDigitsIn(4))$"
        resultLabel.layer.masksToBounds = true
        resultLabel.layer.cornerRadius = 5
        resultLabel.text = "\(floatTextField * usdRate) $"
    }
    @IBAction func convertButton(_ sender: UIButton) {
        fetchCurrency()
    }
}
