//
//  CurrencyViewController.swift
//  LeBaluchon
//
//  Created by Richardier on 13/04/2021.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var euroTextField: UITextField! { didSet { euroTextField?.addDoneToolbar() } } // Contains user's base amount to convert (in €)
    @IBOutlet weak var eurToDollarsRate: UILabel! // euro to dollar conversion rate
    @IBOutlet weak var resultLabel: UILabel! // conversion result
    
    var currencyService = CurrencyServiceFixer()
    var resultCurrency: MainCurrencyInfo?
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        resultLabel.layer.masksToBounds = true
        resultLabel.layer.cornerRadius = 5
        fetchCurrency()
    }
    
    // MARK: - Methods
    
    @IBAction func convertButton(_ sender: UIButton) {
        fetchCurrency()
    }
    
    func fetchCurrency() {
        currencyService.fetchCurrencyData { [weak self] (result) in
            DispatchQueue.main.async {
                switch result { // Switching on result, can be either success or failure
                case .success(let currencyInfo):
                    self?.resultCurrency = currencyInfo
                    self?.updateUI()
                case .failure(let error):
                    print(error)
                    self?.errorFetchingData() // Affiche UIAlert
                }
            }
        }
    }
    
    func updateUI() {
        guard let currency = resultCurrency,
              let euroTextField = euroTextField.text,
              let usdRate = currency.rates.USD else { return }
        eurToDollarsRate.text = "1€ = \(usdRate.shortDigitsIn(4))$"
        
        guard let euroTextFieldFloat = Float(euroTextField.replacingOccurrences(of: ",", with: ".")) else { return }
        resultLabel.text = "\((euroTextFieldFloat * usdRate).shortDigitsIn(4)) $"
    }
}
