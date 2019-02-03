//
//  MainRouter.swift
//  FintechDemo
//
//  Created by Eduardo Nieto on 03/02/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
import UIKit
protocol BaseRouterInterface {
    func create(navigationController : UIViewController)
    func pushToNavigation(viewController: UIViewController, animated: Bool)

}


class BaseRouter {
    let window: UIWindow
    var presentViewController: UIViewController?
    
    var rootViewController: UIViewController {
        
        guard let rootViewController = window.rootViewController else {
            fatalError("There is no rootViewController installed on the window")
        }
        
        return rootViewController
    }
    
    init(window: UIWindow) {
        self.window = window
    }
}

extension BaseRouter {
    
    func presentRootViewController() {
        let shareListViewController = ShareListRouter.create(withMainRouter: self)
        self.create(navigationController: shareListViewController)
        
    }
}

extension BaseRouter: BaseRouterInterface {
    
    
    internal func create(navigationController : UIViewController) {
        let rootViewController = UINavigationController(rootViewController: navigationController)
        window.rootViewController = rootViewController
        presentViewController = navigationController
        
    }
    
    internal func pushToNavigation(viewController: UIViewController, animated: Bool) {
        if  window.rootViewController?.navigationController == nil {
            if rootViewController is UINavigationController {
                CastUtility.castSafely(rootViewController, expectedType: UINavigationController.self).pushViewController(viewController, animated: animated)
            } else if rootViewController.navigationController != nil {
                rootViewController.navigationController!.pushViewController(viewController, animated: animated)
            }
        } else {
            window.rootViewController?.navigationController?.pushViewController(viewController, animated: animated)
        }
        presentViewController = viewController
    }
  
}
