//
//  PreviewViewController.swift
//  sample-ipados-pointer-keyboard
//
//  Created by Ryo Nonaka on 2020/09/10.
//  Copyright © 2020 Ryo Nonaka. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {

    private var constraintY: NSLayoutConstraint?
    private var constraintX: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.text = "テキスト入力欄"
        textField.font = .systemFont(ofSize: 36)
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        view.backgroundColor = .systemBackground

        textField.centerYAnchor.constraint(equalToSystemSpacingBelow: view.centerYAnchor, multiplier: 1).isActive = true
        textField.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: 1).isActive = true
        textField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -160).isActive = true
        updateViewConstraints()

        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "test", style: .plain, target: self, action: #selector(barButtonItem(_:))),
            UIBarButtonItem(image: .strokedCheckmark, style: .plain, target: self, action: #selector(barButtonItem(_:)))
        ]
    }

    @objc func barButtonItem(_ sender: UIBarButtonItem) {
        // none
    }

}
