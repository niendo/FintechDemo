//
//  ShareDetailRouter.swift
//  FintechDemo
//
//  Created by Eduardo Nieto on 03/02/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
import UIKit


protocol ShareDetailRouterFactory {
    static func create(withMainRouter mainRouter: BaseRouterInterface, companyId: Int) -> UIViewController
}

protocol ShareDetailRouterInterface{
    func reloadView()
}

class ShareDetailRouter {
    let mainRouter: BaseRouterInterface
    init(mainRouter: BaseRouterInterface) {
        self.mainRouter = mainRouter
    }
}

extension ShareDetailRouter: ShareDetailRouterInterface {
    
    func reloadView() {
        let viewController = ShareListRouter.create(withMainRouter: mainRouter)
        mainRouter.create(navigationController: viewController)
    }

}

extension ShareDetailRouter: ShareDetailRouterFactory {
    
    static func create(withMainRouter mainRouter: BaseRouterInterface, companyId: Int) -> UIViewController {
        let router = ShareDetailRouter(mainRouter: mainRouter)
        let dataSource = ShareDetailDataSource()
        let interactor = ShareDetailInteractor(shareDetailDatasource: dataSource)
        let presenter = ShareDetailPresenter(router: router, interactor: interactor)
        let view = ShareDetailViewController(nibName: "ShareDetailViewController", bundle: nil, presenter: presenter)
        presenter.view = view
        presenter.setCompanyId(companyId: companyId)
        interactor.interactorOutput = presenter
        return view
    }
}

