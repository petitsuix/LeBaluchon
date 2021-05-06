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
        textToTranslateBubble.doneButtonTapped() // Resigns text field's first responder so the keyboard disappears automatically
    }
    
    func fetchTranslation() {
        translatingActivityIndicator.isHidden = false
        translateButton.isSelected = true
        translateButton.isUserInteractionEnabled = false
        TranslationServiceGoogle.shared.fetchTranslationData(textToTranslateBubble.text) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let translationInfo):
                    self?.resultTranslation = translationInfo
                    self?.updateUI()
                case .failure(let error):
                    print("error: \(error) for weather photo")
                    self?.errorFetchingData()
                }
                self?.translatingActivityIndicator.isHidden = true
                self?.translateButton.isHidden = false
                self?.translateButton.isSelected = false
                self?.translateButton.isUserInteractionEnabled = true
            }
        }
    }
    
    func updateUI() {
        guard let translation = resultTranslation?.data.translations.first?.translatedText.replacingOccurrences(of: "&#39;", with: "'").capitalizingFirstLetter() else { return } // Translated texts' high commas come back as &#39; so we make sure those occurences are replaced with the right symbol
        resultTranslatedText.text = "\(translation)"
    }
}
