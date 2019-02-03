//
//  BaseViewController.swift
//  FintechDemo
//
//  Created by Eduardo Nieto on 03/02/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
import UIKit
open class BaseViewController: UIViewController {
    
    private var loadingSpinner: UIView!
    private var loadingTextLabel:UILabel!
    private var activityView:UIActivityIndicatorView!
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(nibName: String, bundle: Bundle?) {
        
        super.init(nibName: nibName, bundle: bundle)
        self.loadingSpinner = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.loadingSpinner.backgroundColor = .darkGray
        self.loadingSpinner.alpha = 0.8
        
        self.loadingTextLabel = UILabel(frame: CGRect(x: 10, y: (UIScreen.main.bounds.height/2 - 50), width: UIScreen.main.bounds.width-20, height: 30))
        self.loadingTextLabel.textAlignment = .center
        self.loadingTextLabel.textColor = .white
        self.loadingTextLabel.font = UIFont(name: self.loadingTextLabel.font.fontName, size: 18.0)
        
        self.activityView = UIActivityIndicatorView(frame: CGRect(x: (UIScreen.main.bounds.width/2-15), y:(UIScreen.main.bounds.height/2 - 15) , width: 30, height: 30))
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func loadSpinner(text:String) {
        self.loadingTextLabel.text = text
        if !Thread.isMainThread {
            DispatchQueue.main.async {
                self.showSpinner()
            }
        } else {
            self.showSpinner()
        }
    }
    
    public func hideSpinner() {
        if !Thread.isMainThread {
            DispatchQueue.main.async {
                self.removeSpinner()
            }
        } else {
            self.removeSpinner()
        }
    }
    
    private func showSpinner(){
        self.view.addSubview(self.loadingSpinner)
        self.view.addSubview(self.loadingTextLabel)
        self.view.addSubview(self.activityView)
        self.view.bringSubviewToFront(self.loadingSpinner)
        self.view.bringSubviewToFront(self.loadingTextLabel)
        self.view.bringSubviewToFront(self.activityView)
        self.activityView.startAnimating()
    }
    
    private func removeSpinner(){
        self.loadingSpinner.removeFromSuperview()
        self.loadingTextLabel.removeFromSuperview()
        self.activityView.removeFromSuperview()
        self.activityView.stopAnimating()
    }
    
    public func presentError(title: String, message: String, buttonTitle: String) {
        
        DispatchQueue.main.async {
            let errorVC  = UIAlertController(title: title, message: message, preferredStyle:.alert)
            errorVC.addAction(UIAlertAction(title: buttonTitle, style: .cancel, handler: nil))
            self.present(errorVC, animated: true, completion: nil)
        }
        
    }
    
}
