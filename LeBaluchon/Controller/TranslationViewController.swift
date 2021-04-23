//
//  TranslationViewController.swift
//  LeBaluchon
//
//  Created by Richardier on 19/04/2021.
//

import UIKit

class TranslationViewController: UIViewController {
    
    @IBOutlet weak var textToTranslateBubble: UITextView! {
        didSet { textToTranslateBubble?.addDoneCancelToolbar() }
    }
    @IBOutlet weak var resultTranslatedText: UITextView!
    
    var googleApi = GoogleTranslateApi()
    var resultTranslation: MainTranslationInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchTranslation()
    }
    
    func fetchTranslation() {
        googleApi.fetchTranslationData(textToTranslateBubble.text) { [weak self] (result) in
            switch result {
            case .success(let translationInfo):
                self?.resultTranslation = translationInfo
                DispatchQueue.main.async { [weak self] in
                self?.updateUI()
                }
            case .failure(let error):
                print("error: \(error.errorDescription) for weather photo")
            }
        }
    }
    
    func updateUI() {
        resultTranslatedText.isEditable = false
        resultTranslatedText.isScrollEnabled = true
        textToTranslateBubble.keyboardType = .default
        textToTranslateBubble.layer.masksToBounds = true
        textToTranslateBubble.layer.cornerRadius = 5
        resultTranslatedText.layer.masksToBounds = true
        resultTranslatedText.layer.cornerRadius = 5
        guard let translation = resultTranslation?.data.translations.first?.translatedText.replacingOccurrences(of: "&#39;", with: "'").capitalizingFirstLetter() else { return }
        resultTranslatedText.text = "\(translation)"
    }
    
    @IBAction func translate(_ sender: UIButton) {
        fetchTranslation()
    }
}
