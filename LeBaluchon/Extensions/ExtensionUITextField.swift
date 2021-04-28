//
//  ExtensionUITextField.swift
//  LeBaluchon
//
//  Created by Richardier on 15/04/2021.
//

import UIKit


// TODO: bosser sur UITextInput
extension UITextField {
    // ⬇︎ Adds "Done" to keyboard
    func addDoneToolbar() {

        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: target, action: #selector(doneButtonTapped)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        ]
        toolbar.sizeToFit()

        self.inputAccessoryView = toolbar
    }
    @objc func doneButtonTapped() { self.resignFirstResponder() }
}

extension UITextView {
    func addDoneToolbar() {

        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: target, action: #selector(doneButtonTapped)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        ]
        toolbar.sizeToFit()

        self.inputAccessoryView = toolbar
    }
    // Default actions:
    @objc func doneButtonTapped() { self.resignFirstResponder() }
}

