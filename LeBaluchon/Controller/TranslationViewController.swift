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
    @IBOutlet weak var resultTranslatedText: UILabel!
    
    var googleApi = APITranslation()
    var resultTranslation: MainTranslationInfo?
    var translationResult: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchTranslation()
    }
    
    func fetchTranslation() {
        googleApi.start(textToTranslateBubble.text) { (decodedData, error) in
            print(error ?? "")
            self.resultTranslation = decodedData
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
    }
    
    func updateUI() {
        textToTranslateBubble.keyboardType = .default
        textToTranslateBubble.layer.masksToBounds = true
        textToTranslateBubble.layer.cornerRadius = 5
        resultTranslatedText.layer.masksToBounds = true
        resultTranslatedText.layer.cornerRadius = 5
        guard let translation = resultTranslation?.data.translations.first?.translatedText else { return }
        resultTranslatedText.text = "\(translation)"
    }
    
    
    @IBAction func translate(_ sender: UIButton) {
        fetchTranslation()
 /*       guard let translation = resultTranslation?.data.translations.first?.translatedText else { return }
        resultTranslatedText.text = "\(translation)"
    }*/
}
}
