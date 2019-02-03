//
//  ShareListRouter.swift
//  FintechDemo
//
//  Created by Eduardo Nieto on 03/02/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
import UIKit

protocol ShareListRouterFactory {
    static func create(withMainRouter mainRouter: BaseRouterInterface) -> UIViewController
}



protocol ShareListRouterInterface{
    func reloadView()
    func goToCompanyDetail(companyId: Int)
}

class ShareListRouter {
    let mainRouter: BaseRouterInterface
    init(mainRouter: BaseRouterInterface) {
        self.mainRouter = mainRouter
    }
}

extension ShareListRouter: ShareListRouterInterface {

    func reloadView() {
        let viewController = ShareListRouter.create(withMainRouter: mainRouter)
        mainRouter.create(navigationController: viewController)
    }
    
    func goToCompanyDetail(companyId: Int) {
        let detailViewController = ShareDetailRouter.create(withMainRouter: mainRouter, companyId: companyId)
        mainRouter.pushToNavigation(viewController: detailViewController, animated: true)
    }
}

extension ShareListRouter: ShareListRouterFactory {
    
    static func create(withMainRouter mainRouter: BaseRouterInterface) -> UIViewController {
        let router = ShareListRouter(mainRouter: mainRouter)
        let dataSource = ShareListDataSource()
        let interactor = ShareListInteractor(shareListDatasource: dataSource)
        let presenter = ShareListPresenter(router: router, interactor: interactor)
        interactor.interactorOutput = presenter
        let view = ShareListViewController(nibName: "ShareListViewController", bundle: nil, presenter: presenter)
        presenter.view = view
        return view
    }
}
