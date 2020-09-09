//
//  SecondViewController.swift
//  sample-ipados-pointer-keyboard
//
//  Created by Ryo Nonaka on 2020/09/07.
//  Copyright © 2020 Ryo Nonaka. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var alphaShiftButton: UIButton!
    @IBOutlet private weak var alternateButton: UIButton!
    @IBOutlet private weak var commandButton: UIButton!
    @IBOutlet private weak var controlButton: UIButton!
    @IBOutlet private weak var numericPadButton: UIButton!
    @IBOutlet private weak var shiftButton: UIButton!

    private let tapGestureRecognizer = UITapGestureRecognizer()
    private let longPressGestureRecognizer = UILongPressGestureRecognizer()
    private let panGestureRecognizer = UIPanGestureRecognizer()
    private let pinchGestureRecognizer = UIPinchGestureRecognizer()
    private let rotationGestureRecognizer = UIRotationGestureRecognizer()
    private let hoverGestureRecognizer = UIHoverGestureRecognizer()
    private var gestureRecognizers: [UIGestureRecognizer] {
        return [
            tapGestureRecognizer, longPressGestureRecognizer, panGestureRecognizer,
            pinchGestureRecognizer, rotationGestureRecognizer, hoverGestureRecognizer
        ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tapGestureRecognizer.addTarget(self, action: #selector(tap(gestureRecognizer:)))
        longPressGestureRecognizer.addTarget(self, action: #selector(longPress(gestureRecognizer:)))
        panGestureRecognizer.addTarget(self, action: #selector(pan(gestureRecognizer:)))
        pinchGestureRecognizer.addTarget(self, action: #selector(pinch(gestureRecognizer:)))
        rotationGestureRecognizer.addTarget(self, action: #selector(rotation(gestureRecognizer:)))
        hoverGestureRecognizer.addTarget(self, action: #selector(hover(gestureRecognizer:)))

        tapGestureRecognizer.numberOfTouchesRequired = 1
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.buttonMaskRequired = .init(arrayLiteral: .primary, .secondary)
        tapGestureRecognizer.allowedTouchTypes = [UITouch.TouchType.indirectPointer.rawValue] as [NSNumber]

        longPressGestureRecognizer.minimumPressDuration = 0.5
        longPressGestureRecognizer.allowableMovement = 10
        longPressGestureRecognizer.numberOfTouchesRequired = 1
        longPressGestureRecognizer.numberOfTapsRequired = 1
        longPressGestureRecognizer.allowedTouchTypes = [UITouch.TouchType.indirectPointer.rawValue] as [NSNumber]

        panGestureRecognizer.allowedScrollTypesMask = .all
        panGestureRecognizer.minimumNumberOfTouches = 1
        panGestureRecognizer.maximumNumberOfTouches = 1
        panGestureRecognizer.allowedTouchTypes = [UITouch.TouchType.indirectPointer.rawValue] as [NSNumber]

        pinchGestureRecognizer.allowedTouchTypes = [UITouch.TouchType.indirectPointer.rawValue] as [NSNumber]

        rotationGestureRecognizer.allowedTouchTypes = [UITouch.TouchType.indirectPointer.rawValue] as [NSNumber]

        hoverGestureRecognizer.allowedTouchTypes = [UITouch.TouchType.indirectPointer.rawValue] as [NSNumber]

        gestureRecognizers.forEach { view.addGestureRecognizer($0) }
        gestureRecognizers.forEach { $0.isEnabled = true }

        label.text = "none"
    }

}

extension SecondViewController {

    @IBAction func selectTap(didTouchUpInside sender: UIButton) {
        sender.isSelected = !sender.isSelected
        tapGestureRecognizer.isEnabled = sender.isSelected
    }

    @IBAction func selectLongPress(didTouchUpInside sender: UIButton) {
        sender.isSelected = !sender.isSelected
        longPressGestureRecognizer.isEnabled = sender.isSelected
    }

    @IBAction func selectPan(didTouchUpInside sender: UIButton) {
        sender.isSelected = !sender.isSelected
        panGestureRecognizer.isEnabled = sender.isSelected
    }

    @IBAction func selectRotation(didTouchUpInside sender: UIButton) {
        sender.isSelected = !sender.isSelected
        rotationGestureRecognizer.isEnabled = sender.isSelected
    }

    @IBAction func selectPinch(didTouchUpInside sender: UIButton) {
        sender.isSelected = !sender.isSelected
        pinchGestureRecognizer.isEnabled = sender.isSelected
    }

    @IBAction func selectHover(didTouchUpInside sender: UIButton) {
        sender.isSelected = !sender.isSelected
        hoverGestureRecognizer.isEnabled = sender.isSelected
    }

}

extension SecondViewController {

    private func updateModifierFlags(gestureRecognizer: UIGestureRecognizer) {
        alphaShiftButton.isSelected = gestureRecognizer.modifierFlags.contains(.alphaShift)
        alternateButton.isSelected = gestureRecognizer.modifierFlags.contains(.alternate)
        commandButton.isSelected = gestureRecognizer.modifierFlags.contains(.command)
        controlButton.isSelected = gestureRecognizer.modifierFlags.contains(.control)
        numericPadButton.isSelected = gestureRecognizer.modifierFlags.contains(.numericPad)
        shiftButton.isSelected = gestureRecognizer.modifierFlags.contains(.shift)
    }

    @objc func tap(gestureRecognizer: UITapGestureRecognizer) {
        if gestureRecognizer.state == .ended || gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let locations = (0..<gestureRecognizer.numberOfTouches).map { gestureRecognizer.location(ofTouch: $0, in: view) }
            label.text = [
                "tap: \(gestureRecognizer.location(in: view))",
                "buttonMask: \(gestureRecognizer.buttonMask)",
                "",
                "numberOfTouches: \(gestureRecognizer.numberOfTouches)",
                "\(locations)",
            ].joined(separator: "\n")
        }
        if gestureRecognizer.state == .ended {
            label.textColor = .placeholderText
        } else {
            label.textColor = .darkText
        }
        updateModifierFlags(gestureRecognizer: gestureRecognizer)
    }

    @objc func longPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .ended || gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let locations = (0..<gestureRecognizer.numberOfTouches).map { gestureRecognizer.location(ofTouch: $0, in: view) }
            label.text = [
                "longPress: \(gestureRecognizer.location(in: view))",
                "buttonMask: \(gestureRecognizer.buttonMask)",
                "",
                "numberOfTouches: \(gestureRecognizer.numberOfTouches)",
                "\(locations)",
            ].joined(separator: "\n")
        }
        if gestureRecognizer.state == .ended {
            label.textColor = .placeholderText
        } else {
            label.textColor = .darkText
        }
        updateModifierFlags(gestureRecognizer: gestureRecognizer)
    }

    @objc func pan(gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .ended || gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let locations = (0..<gestureRecognizer.numberOfTouches).map { gestureRecognizer.location(ofTouch: $0, in: view) }
            label.text = [
                "pan: \(gestureRecognizer.location(in: view))",
                "buttonMask: \(gestureRecognizer.buttonMask)",
                "translation: \(gestureRecognizer.translation(in: view))",
                "numberOfTouches: \(gestureRecognizer.numberOfTouches)",
                "\(locations)",
            ].joined(separator: "\n")
        }
        if gestureRecognizer.state == .ended {
            label.textColor = .placeholderText
        } else {
            label.textColor = .darkText
        }
        updateModifierFlags(gestureRecognizer: gestureRecognizer)
    }

    @objc func rotation(gestureRecognizer: UIRotationGestureRecognizer) {
        if gestureRecognizer.state == .ended || gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let locations = (0..<gestureRecognizer.numberOfTouches).map { gestureRecognizer.location(ofTouch: $0, in: view) }
            label.text = [
                "rotation: \(gestureRecognizer.location(in: view))",
                "buttonMask: \(gestureRecognizer.buttonMask)",
                "rotation: \(gestureRecognizer.rotation)",
                "numberOfTouches: \(gestureRecognizer.numberOfTouches)",
                "\(locations)",
            ].joined(separator: "\n")
        }
        if gestureRecognizer.state == .ended {
            label.textColor = .placeholderText
        } else {
            label.textColor = .darkText
        }
        updateModifierFlags(gestureRecognizer: gestureRecognizer)
    }

    @objc func pinch(gestureRecognizer: UIPinchGestureRecognizer) {
        if gestureRecognizer.state == .ended || gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let locations = (0..<gestureRecognizer.numberOfTouches).map { gestureRecognizer.location(ofTouch: $0, in: view) }
            label.text = [
                "pinch: \(gestureRecognizer.location(in: view))",
                "buttonMask: \(gestureRecognizer.buttonMask)",
                "scale: \(gestureRecognizer.scale)",
                "numberOfTouches: \(gestureRecognizer.numberOfTouches)",
                "\(locations)",
            ].joined(separator: "\n")
        }
        if gestureRecognizer.state == .ended {
            label.textColor = .placeholderText
        } else {
            label.textColor = .darkText
        }
        updateModifierFlags(gestureRecognizer: gestureRecognizer)
    }

    @objc func hover(gestureRecognizer: UIHoverGestureRecognizer) {
        if gestureRecognizer.state == .ended || gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let locations = (0..<gestureRecognizer.numberOfTouches).map { gestureRecognizer.location(ofTouch: $0, in: view) }
            label.text = [
                "hover: \(gestureRecognizer.location(in: view))",
                "buttonMask: \(gestureRecognizer.buttonMask)",
                "",
                "numberOfTouches: \(gestureRecognizer.numberOfTouches)",
                "\(locations)",
            ].joined(separator: "\n")
        }
        if gestureRecognizer.state == .ended {
            label.textColor = .placeholderText
        } else {
            label.textColor = .darkText
        }
        updateModifierFlags(gestureRecognizer: gestureRecognizer)
    }

}

