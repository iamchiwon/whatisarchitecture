//
//  TitleInputViewController.swift
//  MyToDo
//
//  Created by Chiwon Song on 2020/07/25.
//  Copyright © 2020 Chiwon Song. All rights reserved.
//

import UIKit

class TitleInputViewController: UIViewController {
    var onTitleInput: ((String) -> Void)?

    @IBOutlet var titleTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                         action: #selector(onBackgroundTouched)))
    }

    @objc func onBackgroundTouched() {
        view.endEditing(true)
    }

    @IBAction func onCancel() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onDone() {
        guard let text = titleTextField.text, !text.isEmpty,
            let callback = onTitleInput else {
            onCancel()
            return
        }

        callback(text)
        dismiss(animated: true, completion: nil)
    }
}
