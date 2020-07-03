//
//  BaseViewProtocol.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 21/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import PKHUD
import SafariServices
import UIKit

protocol BaseViewProtocol: AnyObject {
    func disable(_ button: UIButton)
    func enable(_ button: UIButton)
    func createSpinnerView()
    func removeSpinnerView()
    func presentSafariViewController(for url: URL, viewController: UIViewController)
}

extension BaseViewProtocol {
    /**
     * Mark button as disabled
     */
    func disableNoNnimate(_ button: UIButton) {
        // And off
        button.isUserInteractionEnabled = false
        button.isEnabled = false
        button.alpha = 0.5
    }

    /**
     * Mark button as disabled
     */
    func disable(_ button: UIButton) {
        // And off
        button.isUserInteractionEnabled = false
        button.isEnabled = false

        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: [.beginFromCurrentState],
                       animations: {
                        button.alpha = 0.5
        },
                       completion: nil)
    }

    /**
     * Mark button as enabled
     */
    func enable(_ button: UIButton) {
        button.isUserInteractionEnabled = true
        button.isEnabled = true

        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: [.beginFromCurrentState],
                       animations: {
                        button.alpha = 1.0
        },
                       completion: nil)
    }

    // Add the spinner in view controller
    func createSpinnerView() {
        HUD.show(.progress)
    }

    // Remove the spinner in view controller
    func removeSpinnerView() {
        HUD.hide()
    }

    func presentSafariViewController(for url: URL, viewController: UIViewController) {
        let safariController = SFSafariViewController(url: url)
        if #available(iOS 10, *) {
            safariController.preferredControlTintColor = .barTintColor
        } else {
            safariController.view.tintColor = .barTintColor
        }
        safariController.preferredBarTintColor = .white
        safariController.modalPresentationStyle = .overFullScreen

        viewController.present(safariController, animated: true, completion: nil)
    }
}
