//
//  ViewController.swift
//  smallChildViewController
//
//  Created by Aleksandr Bolotov on 15.07.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Present", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.borderColor = .none
        button.backgroundColor = .none
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.addTarget(self, action: #selector(showPopupVC(sender:)), for: .touchUpInside)
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc
    private func showPopupVC(sender: UIButton) {
        let popupVC = UINavigationController(rootViewController: PopupViewController())
        popupVC.modalPresentationStyle = .popover
        // прикол конечно, если делегат указать перед modalPresentationStyle  другой результат
        popupVC.popoverPresentationController?.delegate = self
        popupVC.popoverPresentationController?.sourceView = sender
        popupVC.popoverPresentationController?.sourceRect = sender.bounds
        popupVC.popoverPresentationController?.permittedArrowDirections = .up
        self.present(popupVC, animated: true)
    }
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

    public func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }

    public func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        button.setTitleColor(.lightGray, for: .normal)
    }

    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        button.setTitleColor(.systemBlue, for: .normal)
    }
    
}

