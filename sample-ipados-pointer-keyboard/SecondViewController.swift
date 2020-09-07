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

    override func viewDidLoad() {
        super.viewDidLoad()
        tapGestureRecognizer.addTarget(self, action: #selector(tap(gestureRecognizer:)))
        longPressGestureRecognizer.addTarget(self, action: #selector(longPress(gestureRecognizer:)))
        panGestureRecognizer.addTarget(self, action: #selector(pan(gestureRecognizer:)))
        pinchGestureRecognizer.addTarget(self, action: #selector(pinch(gestureRecognizer:)))
        rotationGestureRecognizer.addTarget(self, action: #selector(rotation(gestureRecognizer:)))
        hoverGestureRecognizer.addTarget(self, action: #selector(hover(gestureRecognizer:)))

        view.addGestureRecognizer(tapGestureRecognizer)
        view.addGestureRecognizer(longPressGestureRecognizer)
        view.addGestureRecognizer(panGestureRecognizer)
        view.addGestureRecognizer(pinchGestureRecognizer)
        view.addGestureRecognizer(rotationGestureRecognizer)
        view.addGestureRecognizer(hoverGestureRecognizer)

        tapGestureRecognizer.buttonMaskRequired = .secondary
        longPressGestureRecognizer.numberOfTouchesRequired = 1
        panGestureRecognizer.allowedTouchTypes = [UITouch.TouchType.indirectPointer.rawValue] as [NSNumber]
        panGestureRecognizer.allowedScrollTypesMask = .continuous

        label.text = "none"
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

