//
//  PopupViewController.swift
//  smallChildViewController
//
//  Created by Aleksandr Bolotov on 15.07.2023.
//

import Foundation
import UIKit

final class PopupViewController: UIViewController {
        
    private let largeSize: CGSize = CGSize(width: 300, height: 280)
    private let smallSize: CGSize = CGSize(width: 300, height: 150)
    
    private lazy var segment: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["280pt", "150pt"])
        segment.selectedSegmentIndex = 0
        segment.backgroundColor = .systemGray5
        navigationItem.titleView = segment
        return segment
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        
        preferredContentSize = largeSize
        popoverPresentationController?.presentedViewController.preferredContentSize = largeSize
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        
        segment.addTarget(self, action: #selector(self.changeSegmentAction(_:)), for: .valueChanged)
        setupCloseButton()
    }
    
    private func setupCloseButton() {
        let closeAction = UIAction(handler: { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
            if let popupVC = self?.popoverPresentationController {
                popupVC.delegate?.presentationControllerDidDismiss?(popupVC)
            }
        })
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .close, primaryAction: closeAction, menu: nil)
    }
    
    @objc
    private func changeSegmentAction(_ sender: UISegmentedControl!) {
        preferredContentSize = (sender.selectedSegmentIndex == 0) ? largeSize : smallSize
        popoverPresentationController?.presentedViewController.preferredContentSize = (sender.selectedSegmentIndex == 0) ? largeSize : smallSize
    }
}

