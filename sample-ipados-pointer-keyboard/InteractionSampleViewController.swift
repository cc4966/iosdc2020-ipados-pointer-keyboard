//
//  InteractionSampleViewController.swift
//  sample-ipados-pointer-keyboard
//
//  Created by Ryo Nonaka on 2020/09/10.
//  Copyright © 2020 Ryo Nonaka. All rights reserved.
//

import UIKit

class InteractionSampleViewController: UIViewController {

    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var previewingView: UIView!
    @IBOutlet private weak var contextMenuView: UIView!
    @IBOutlet private weak var contextMenuOnlyView: UIView!
    @IBOutlet private weak var dragView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        contextMenuView.isAccessibilityElement = true
        contextMenuView.addInteraction(UIContextMenuInteraction(delegate: self))
        contextMenuOnlyView.isAccessibilityElement = true
        contextMenuOnlyView.addInteraction(UIContextMenuInteraction(delegate: self))

        registerForPreviewing(with: self, sourceView: previewingView)
        previewingView.isAccessibilityElement = true
        previewingView.accessibilityRespondsToUserInteraction = true

        let dragInteraction = UIDragInteraction(delegate: self)
        dragInteraction.isEnabled = true // for iOS
        dragView.addInteraction(dragInteraction)
    }

}

extension InteractionSampleViewController: UIDragInteractionDelegate {

    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        return [
            UIDragItem(itemProvider: NSItemProvider())
        ]
    }

}

extension InteractionSampleViewController {

    @objc func handleSelector(_ sender: Any) {
        label.text = "\(sender)"
    }

}

extension PreviewViewController {

    override var previewActionItems: [UIPreviewActionItem] {
        return [
            UIPreviewAction(title: "PreviewAction", style: .default, handler: { action, viewController in
                print(action)
            }),
            UIPreviewActionGroup(title: "PreviewActionGroup", style: .destructive, actions: [
                UIPreviewAction(title: "これ以上ネストできない", style: .selected, handler: { action, viewController in
                    print(action)
                })
            ])
        ]
    }

}

extension InteractionSampleViewController: UIViewControllerPreviewingDelegate {

    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        previewingContext.sourceRect = previewingView.bounds
        return PreviewViewController()
    }

    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }

}

extension InteractionSampleViewController: UIContextMenuInteractionDelegate {

    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        guard let viewController = animator.previewViewController else {
            return
        }
        animator.preferredCommitStyle = .pop
        animator.addCompletion {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }

    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: {
            guard interaction.view == self.contextMenuView else {
                return nil
            }
            return PreviewViewController()
        }) { elements in
            return UIMenu(title: "menu title", image: .actions, identifier: nil, options: .init(), children: [
                UICommand(title: "Command", image: .add, action: #selector(self.handleSelector(_:)), propertyList: nil, alternates: [], discoverabilityTitle: "Command discoverabilityTitle", attributes: .init(), state: .off),
                UIKeyCommand(title: "KeyCommand", image: .remove, action: #selector(self.handleSelector(_:)), input: "T", modifierFlags: .command, propertyList: nil, alternates: [], discoverabilityTitle: "KeyCommand discoverabilityTitle", attributes: .destructive, state: .on),
                UIMenu(title: "submenu", image: nil, identifier: nil, options: .init(), children: [
                    UIAction(title: "Action", handler: { action in
                        self.label.text = "\(action)"
                    }),
                    UIMenu(title: "subsubmenu", image: nil, identifier: nil, options: .init(), children: [
                        UIAction(title: "Action", handler: { action in
                            self.label.text = "\(action)"
                        })
                    ])
                ])
            ])
        }
    }

}
