//
//  BaseViewController.swift
//  ExchangeRate
//
//  Created by Somnath Rasal on 04/05/21.
//

import UIKit

///Class intended to provide methods and properties which would be common to all ViewControllers.
class BaseViewController: UIViewController {

    private var vSpinner : UIView?

    /**
     Add Spinner View on given view.
     
     - Parameter onView: View on which spinner view is getting added.
    */
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        self.vSpinner = spinnerView
    }
    
    /**
     Removes Spinner View from parent view.
    */
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
    
    /**
     Displays Alert with given title and message o view.

     - Parameters:
        - title: Title of the alert.
        - withMessage: Tmessage of the alert.
    */
    func showAlert(withTitle title: String, withMessage message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
            
        })
        alert.addAction(ok)
        
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }

}
