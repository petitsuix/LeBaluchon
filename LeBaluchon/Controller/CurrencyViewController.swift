//
//  CurrencyViewController.swift
//  LeBaluchon
//
//  Created by Richardier on 13/04/2021.
//

import UIKit

class CurrencyViewController: UIViewController {

    
    
    var fixerApi = APICurrency()
    var resultCurrency: MainCurrencyInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fixerApi.start() { (decodedData, error) in
            print(error ?? "")
            self.resultCurrency = decodedData
            self.updateUI()
        }
    }
    func updateUI() {
        guard let currency = resultCurrency else { return }
        DispatchQueue.main.async { [self] in
            
        }
    }
    
}
