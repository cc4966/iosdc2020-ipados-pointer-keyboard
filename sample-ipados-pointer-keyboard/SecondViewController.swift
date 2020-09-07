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

        gestureRecognizers.forEach { view.addGestureRecognizer($0) }
        gestureRecognizers.forEach { $0.isEnabled = false }

        tapGestureRecognizer.buttonMaskRequired = .secondary
        longPressGestureRecognizer.numberOfTouchesRequired = 1
        panGestureRecognizer.allowedTouchTypes = [UITouch.TouchType.indirectPointer.rawValue] as [NSNumber]
        panGestureRecognizer.allowedScrollTypesMask = .continuous

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

    @objc func tap(gestureRecognizer: UITapGestureRecognizer) {
        if gestureRecognizer.state == .ended || gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let locations = (0..<gestureRecognizer.numberOfTouches).map { gestureRecognizer.location(ofTouch: $0, in: view) }
            label.text = [
                "tap: \(gestureRecognizer.location(in: view))",
                "buttonMask: \(gestureRecognizer.buttonMask)",
                "numberOfTouches: \(gestureRecognizer.numberOfTouches) | \(locations)",
                ""
            ].joined(separator: "\n")
        }
    }

    @objc func longPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .ended || gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let locations = (0..<gestureRecognizer.numberOfTouches).map { gestureRecognizer.location(ofTouch: $0, in: view) }
            label.text = [
                "longPress: \(gestureRecognizer.location(in: view))",
                "buttonMask: \(gestureRecognizer.buttonMask)",
                "numberOfTouches: \(gestureRecognizer.numberOfTouches) | \(locations)",
                ""
            ].joined(separator: "\n")
        }
    }

    @objc func pan(gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .ended || gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let locations = (0..<gestureRecognizer.numberOfTouches).map { gestureRecognizer.location(ofTouch: $0, in: view) }
            label.text = [
                "pan: \(gestureRecognizer.location(in: view))",
                "buttonMask: \(gestureRecognizer.buttonMask)",
                "numberOfTouches: \(gestureRecognizer.numberOfTouches) | \(locations)",
                "translation: \(gestureRecognizer.translation(in: view))"
            ].joined(separator: "\n")
        }
    }

    @objc func rotation(gestureRecognizer: UIRotationGestureRecognizer) {
        if gestureRecognizer.state == .ended || gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let locations = (0..<gestureRecognizer.numberOfTouches).map { gestureRecognizer.location(ofTouch: $0, in: view) }
            label.text = [
                "rotation: \(gestureRecognizer.location(in: view))",
                "buttonMask: \(gestureRecognizer.buttonMask)",
                "numberOfTouches: \(gestureRecognizer.numberOfTouches) | \(locations)",
                "rotation: \(gestureRecognizer.rotation)"
            ].joined(separator: "\n")
        }
    }

    @objc func pinch(gestureRecognizer: UIPinchGestureRecognizer) {
        if gestureRecognizer.state == .ended || gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let locations = (0..<gestureRecognizer.numberOfTouches).map { gestureRecognizer.location(ofTouch: $0, in: view) }
            label.text = [
                "pinch: \(gestureRecognizer.location(in: view))",
                "buttonMask: \(gestureRecognizer.buttonMask)",
                "numberOfTouches: \(gestureRecognizer.numberOfTouches) | \(locations)",
                "scale: \(gestureRecognizer.scale)"
            ].joined(separator: "\n")
        }
    }

    @objc func hover(gestureRecognizer: UIHoverGestureRecognizer) {
        if gestureRecognizer.state == .ended || gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let locations = (0..<gestureRecognizer.numberOfTouches).map { gestureRecognizer.location(ofTouch: $0, in: view) }
            label.text = [
                "hover: \(gestureRecognizer.location(in: view))",
                "buttonMask: \(gestureRecognizer.buttonMask)",
                "numberOfTouches: \(gestureRecognizer.numberOfTouches) | \(locations)",
                ""
            ].joined(separator: "\n")
        }
    }

}

