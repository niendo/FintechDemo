//
//  ShareListPresenter.swift
//  FintechDemo
//
//  Created by Eduardo Nieto on 03/02/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
protocol ShareListPresenterInterface {
    func viewDidLoad()
    func reloadView()
    func goToDetail(companyId: Int)
}

class ShareListPresenter {
    var view: ShareListViewControllerInterface?
    let router: ShareListRouterInterface
    let interactor: ShareListInteractorInputInterface
    
    init(router: ShareListRouterInterface, interactor: ShareListInteractor) {
        self.router = router
        self.interactor = interactor
    }
}

extension ShareListPresenter: ShareListPresenterInterface {

    func viewDidLoad() {
        self.getCompanies()
        self.view?.isLoading(true)
    }
    
    func reloadView() {
        
    }
    
    private func getCompanies() {
        self.interactor.getCompanies()
    }
    
    func goToDetail(companyId: Int) {
        self.router.goToCompanyDetail(companyId: companyId)
    }

}

extension ShareListPresenter: ShareListInteractorOutputInterface {
    func getCompaniesSuccess(companies: [CompanyModel]?) {
        self.view?.setCompanies(companies: companies)
        self.view?.isLoading(false)
    }
    
    func getCompaniesError(error: String) {
        self.view?.showError(error: error)
        self.view?.isLoading(false)
    }
}
