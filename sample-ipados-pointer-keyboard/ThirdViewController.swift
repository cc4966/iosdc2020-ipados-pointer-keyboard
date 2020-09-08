//
//  ThirdViewController.swift
//  sample-ipados-pointer-keyboard
//
//  Created by Ryo Nonaka on 2020/09/08.
//  Copyright © 2020 Ryo Nonaka. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var commandButton: UIButton!
    @IBOutlet private weak var shiftButton: UIButton!
    @IBOutlet private weak var aButton: UIButton!
    @IBOutlet private weak var aCommandButton: UIButton!
    @IBOutlet private weak var aCommandShiftButton: UIButton!

    override var keyCommands: [UIKeyCommand]? {
        return [
            UIKeyCommand(input: "", modifierFlags: .shift, action: #selector(handleKeyCommand(command:)), discoverabilityTitle: "Shift+none"), // deprecated
            UIKeyCommand(input: "", modifierFlags: .command, action: #selector(handleKeyCommand(command:))),
            UIKeyCommand(input: "A", modifierFlags: .init(), action: #selector(handleKeyCommand(command:))),
            UIKeyCommand(input: "A", modifierFlags: .command, action: #selector(handleKeyCommand(command:))),
            UIKeyCommand(title: "Command+Shift+A", image: .add, action: #selector(handleKeyCommand(command:)), input: "A", modifierFlags: .init(arrayLiteral: .command, .shift), propertyList: nil, alternates: [], discoverabilityTitle: "ここに説明")
        ] + (super.keyCommands ?? []) // addKeyCommands等で管理される分
    }

    class FocusableLabel: UILabel {
        override var canBecomeFocused: Bool {
            return true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.tintColor = .blue
        label.accessibilityRespondsToUserInteraction = true
        label.tintColor = .red

        let containerView = UIView(frame: CGRect(x: 80, y: 80, width: 240, height: 80))
        containerView.tintColor = .green
        let focusableLabel = FocusableLabel(frame: CGRect(x: 0, y: 0, width: 240, height: 80))
        focusableLabel.text = "focusableLabel"
        focusableLabel.tintColor = .red
        focusableLabel.isUserInteractionEnabled = true
        containerView.addSubview(focusableLabel)
        view.addSubview(containerView)

        addKeyCommand(UIKeyCommand(title: "Command+Shift+F", image: .add, action: #selector(handleKeyCommand(command:)), input: "F", modifierFlags: .init(arrayLiteral: .command, .shift), propertyList: nil, alternates: [], discoverabilityTitle: "addKeyCommand"))
    }

}

extension ThirdViewController {

    @objc func handleKeyCommand(command: UIKeyCommand) {
        print(command)
        let button: UIButton
        if command.title == "Command+Shift+A" {
            button = aCommandShiftButton
        } else if command.input == "A" {
            if command.modifierFlags == .command {
                button = aCommandButton
            } else {
                button = aButton
            }
        } else {
            if command.modifierFlags == .command {
                button = commandButton
            } else {
                button = shiftButton
            }
        }
        button.isSelected = !button.isSelected
    }

}
