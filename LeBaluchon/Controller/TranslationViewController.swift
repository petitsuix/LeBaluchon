//
//  TranslationViewController.swift
//  LeBaluchon
//
//  Created by Richardier on 19/04/2021.
//

import UIKit

class TranslationViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var textToTranslateBubble: UITextView! {
        didSet { textToTranslateBubble?.addDoneToolbar() }
    }
    @IBOutlet weak var resultTranslatedText: UITextView!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var translatingActivityIndicator: UIActivityIndicatorView!
    
    var googleApi = TranslationServiceGoogle()
    var resultTranslation: MainTranslationInfo?
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        resultTranslatedText.isEditable = false
        resultTranslatedText.isScrollEnabled = true
        textToTranslateBubble.keyboardType = .default
        textToTranslateBubble.layer.masksToBounds = true
        textToTranslateBubble.layer.cornerRadius = 5
        resultTranslatedText.layer.masksToBounds = true
        resultTranslatedText.layer.cornerRadius = 5
        fetchTranslation()
    }
    
    // MARK: - Methods
    
    @IBAction func translate(_ sender: UIButton) {
        fetchTranslation()
        textToTranslateBubble.doneButtonTapped()
    }
    
    func fetchTranslation() {
        translatingActivityIndicator.isHidden = false
        translateButton.isHidden = true
        googleApi.fetchTranslationData(textToTranslateBubble.text) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let translationInfo):
                    self?.resultTranslation = translationInfo
                    self?.updateUI()
                case .failure(let error):
                    print("error: \(error) for weather photo")
                    self?.errorFetchingData()
                }
            }
        }
        translateButton.isHidden = false
        translatingActivityIndicator.isHidden = true
    }
    
    func updateUI() {
        guard let translation = resultTranslation?.data.translations.first?.translatedText.replacingOccurrences(of: "&#39;", with: "'").capitalizingFirstLetter() else { return }
        resultTranslatedText.text = "\(translation)"
    }
}
