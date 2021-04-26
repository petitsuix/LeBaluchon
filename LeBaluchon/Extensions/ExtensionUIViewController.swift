//
//  ExtensionUIViewController.swift
//  LeBaluchon
//
//  Created by Richardier on 26/04/2021.
//

import UIKit

extension UIViewController {
    
    func errorFetchingData() {
        let alertVC = UIAlertController(title: "Erreur", message: "Impossible de charger les données", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
