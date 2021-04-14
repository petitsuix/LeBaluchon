//
//  CurrencyViewController.swift
//  LeBaluchon
//
//  Created by Richardier on 13/04/2021.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    @IBOutlet weak var euroTextView: UITextView!
    @IBOutlet weak var dollarsTextView: UITextView!
    @IBOutlet weak var eurToDollarsRate: UILabel!
    
    var fixerApi = APICurrency()
    var resultCurrency: MainCurrencyInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fixerApi.start() { (decodedData, error) in
            print(error ?? "")
            self.resultCurrency = decodedData
            DispatchQueue.main.async { [self] in
                self.updateUI()
            }
            
        }
    }
    func updateUI() {
        guard let currency = resultCurrency else { return }
        guard let usdRate = currency.rates.USD else { return }
        self.eurToDollarsRate.text = "1€ = \(usdRate.shortDigitsIn(3))$"
    }
}
