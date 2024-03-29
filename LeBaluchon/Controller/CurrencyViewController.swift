//
//  CurrencyViewController.swift
//  LeBaluchon
//
//  Created by Richardier on 13/04/2021.
//

import UIKit

final class CurrencyViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var euroTextField: UITextField! { didSet { euroTextField?.addDoneToolbar() } } // Contains user's base amount to convert (in €)
    @IBOutlet weak var eurToDollarsRate: UILabel! // euro to dollar conversion rate
    @IBOutlet weak var resultLabel: UILabel! // conversion result
    @IBOutlet weak var centerStackView: UIStackView!
    @IBOutlet weak var loadingCurrencyViewActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var convertButton: UIButton!
    
    var currencyServiceFixer = CurrencyServiceFixer(urlSession: URLSession(configuration: .default), baseUrl: "http://data.fixer.io/api/latest")
    var resultCurrency: MainCurrencyInfo?
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        resultLabel.layer.masksToBounds = true
        resultLabel.layer.cornerRadius = 5
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        fetchCurrency() // Ensures that a new request is done everytime the user switches from one view to another, so the data is kept up to date without having to launch the app again
    }
    
    // MARK: - Methods
    
    @IBAction func didTapConvertButton(_ sender: UIButton) {
        fetchCurrency()
        euroTextField.doneButtonTapped() // Resigns text field's first responder so the keyboard disappears automatically
    }
    
    private func fetchCurrency() {
        convertButton.isSelected = true
        loadingCurrencyViewActivityIndicator.isHidden = false
        convertButton.isUserInteractionEnabled = false
        currencyServiceFixer.fetchCurrencyData { [weak self] (result) in // Calling request method. Weak self is to avoid any retain cycle that could provoke memory leaks and crashes (deinit could never be called, memory would never be freed)
            DispatchQueue.main.async { // Switching work item to asynchronous so it runs elsewhere while code is still being executed
                switch result {
                case .success(let currencyInfo):
                    self?.resultCurrency = currencyInfo
                    self?.updateUI()
                case .failure(let error):
                    print(error)
                    self?.errorFetchingData() // Shows UIAlert
                }
                self?.loadingCurrencyViewActivityIndicator.isHidden = true
                self?.convertButton.isHidden = false
                self?.convertButton.isSelected = false
                self?.convertButton.isUserInteractionEnabled = true
            }
        }
    }
    
    private func updateUI() {
        guard let currency = resultCurrency,
              let euroTextField = euroTextField.text,
              let usdRate = currency.rates.USD else { return }
        eurToDollarsRate.text = "1€ = \(usdRate.shortDigitsIn(4))$"
        guard let euroTextFieldFloat = Float(euroTextField.replacingOccurrences(of: ",", with: ".")) else { return } // Handling of different decimal separators according to keyboard region type
        resultLabel.text = "\((euroTextFieldFloat * usdRate).shortDigitsIn(4)) $"
    }
}
