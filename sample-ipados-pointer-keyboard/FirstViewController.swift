//
//  FirstViewController.swift
//  sample-ipados-pointer-keyboard
//
//  Created by Ryo Nonaka on 2020/09/07.
//  Copyright © 2020 Ryo Nonaka. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet private weak var label01: UILabel!
    @IBOutlet private weak var label02: UILabel!
    @IBOutlet private weak var label03: UILabel!
    @IBOutlet private weak var label04: UILabel!
    @IBOutlet private weak var label05: UILabel!
    @IBOutlet private weak var label10: UILabel!
    @IBOutlet private weak var label20: UILabel!
    @IBOutlet private weak var label30: UILabel!
    @IBOutlet private weak var button11: UIButton!
    @IBOutlet private weak var button12: UIButton!
    @IBOutlet private weak var button13: UIButton!
    @IBOutlet private weak var button14: UIButton!
    @IBOutlet private weak var button15: UIButton!
    @IBOutlet private weak var button21: UIButton!
    @IBOutlet private weak var button22: UIButton!
    @IBOutlet private weak var button23: UIButton!
    @IBOutlet private weak var button24: UIButton!
    @IBOutlet private weak var button25: UIButton!
    @IBOutlet private weak var button31: UIButton!
    @IBOutlet private weak var button32: UIButton!
    @IBOutlet private weak var button33: UIButton!
    @IBOutlet private weak var button34: UIButton!
    @IBOutlet private weak var button35: UIButton!
    private var buttons: [UIButton] {
        return [
            button11, button12, button13, button14, button15,
            button21, button22, button23, button24, button25,
            button31, button32, button33, button34, button35
        ]
    }
    @IBOutlet private weak var smallButton0: UIButton!
    @IBOutlet private weak var smallButton1: UIButton!
    @IBOutlet private weak var smallButton2: UIButton!
    @IBOutlet private weak var smallButton3: UIButton!
    @IBOutlet private weak var smallButton4: UIButton!
    @IBOutlet private weak var smallButton5: UIButton!
    @IBOutlet private weak var smallButton6: UIButton!
    @IBOutlet private weak var smallButton7: UIButton!
    @IBOutlet private weak var smallButton8: UIButton!
    @IBOutlet private weak var smallButton9: UIButton!
    private var smallButtons: [UIButton] {
        return [
            smallButton0, smallButton1, smallButton2, smallButton3, smallButton4,
            smallButton5, smallButton6, smallButton7, smallButton8, smallButton9
        ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        label01.text = "hover"
        [button11, button21, button31].forEach { button in
            guard let button = button else { return }
            button.pointerStyleProvider = { _, _, _ in
                return UIPointerStyle(effect: .hover(UITargetedPreview(view: button)))
            }
        }
        label02.font = .systemFont(ofSize: 24)
        label02.text = "highlight"
        [button12, button22, button32].forEach { button in
            guard let button = button else { return }
            button.pointerStyleProvider = { _, _, _ in
                return UIPointerStyle(effect: .highlight(UITargetedPreview(view: button)))
            }
        }
        label03.font = .systemFont(ofSize: 24)
        label03.text = "automatic"
        [button13, button23, button33].forEach { button in
            guard let button = button else { return }
            button.pointerStyleProvider = { _, _, _ in
                return UIPointerStyle(effect: .automatic(UITargetedPreview(view: button)))
            }
        }
        label04.text = "lift"
        [button14, button24, button34].forEach { button in
            guard let button = button else { return }
            button.pointerStyleProvider = { _, _, _ in
                return UIPointerStyle(effect: .lift(UITargetedPreview(view: button)))
            }
        }
        label05.font = .systemFont(ofSize: 30)
        label05.text = "default"

        label10.text = "false"
        [button11, button12, button13, button14, button15].forEach { button in
            guard let button = button else { return }
            button.isPointerInteractionEnabled = false
        }
        label20.text = "true"
        [button21, button22, button23, button24, button25].forEach { button in
            guard let button = button else { return }
            button.isPointerInteractionEnabled = true // pointerStyleProviderを設定するとtrueになる
        }
        label30.text = "true"
        [button31, button32, button33, button34, button35].forEach { button in
            guard let button = button else { return }
            button.isPointerInteractionEnabled = true // pointerStyleProviderを設定するとtrueになる
        }

        guard let font = CTFontCreateUIFontForLanguage(.system, 36, nil) else {
            return
        }
        let ascender = CTFontGetAscent(font)
        smallButtons.forEach { button in
            button.isPointerInteractionEnabled = true
            guard let currentTitle = button.currentTitle, !currentTitle.isEmpty else {
                return
            }
            // PostScript
            let name = currentTitle == "2" ? "two" : currentTitle == "0" ? "zero" : currentTitle
            button.pointerStyleProvider = { _, _, _ in
                var glyph = CTFontGetGlyphWithName(font, name as CFString)
                let advance = CTFontGetAdvancesForGlyphs(font, .horizontal, &glyph, nil, 1)
                var transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: -CGFloat(advance) / 2, y: 18 - ascender)
                guard let path = CTFontCreatePathForGlyph(font, glyph, &transform) else {
                    return nil
                }
                return UIPointerStyle(shape: UIPointerShape.path(UIBezierPath(cgPath: path)))
            }
        }
    }

}

extension FirstViewController {

    @IBAction func changeButtonBackground(didTOuchUpInside sender: UIButton) {
        sender.isSelected = !sender.isSelected
        buttons.forEach { button in
            button.backgroundColor = sender.isSelected ? .lightGray : nil
        }
    }

}

