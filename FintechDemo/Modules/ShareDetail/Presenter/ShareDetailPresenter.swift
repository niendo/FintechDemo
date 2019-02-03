//
//  ShareDetailPresenter.swift
//  FintechDemo
//
//  Created by Eduardo Nieto on 03/02/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
protocol ShareDetailPresenterInterface {
    func viewDidLoad()
    func viewWillDisappepear()
    func setCompanyId(companyId: Int)
}

class ShareDetailPresenter {
    var view: ShareDetailViewControllerInterface?
    let router: ShareDetailRouterInterface
    let interactor: ShareDetailInteractorInputInterface
    
    let timerInterval: Double = 10
    var timer: Timer?
    
    var companyId: Int?
    
    init(router: ShareDetailRouterInterface, interactor: ShareDetailInteractor) {
        self.router = router
        self.interactor = interactor
    }
}

extension ShareDetailPresenter: ShareDetailPresenterInterface {

    
    func setCompanyId(companyId: Int) {
        self.companyId = companyId
        self.getCompany()
    }
    
    func viewDidLoad() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: self.timerInterval,
                                         target: self,
                                         selector: #selector(self.reloadView),
                                         userInfo: nil,
                                         repeats: true)
        }
    }
    
    func viewWillDisappepear() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func reloadView() {
        self.getCompany()
    }
    
    private func getCompany() {
        if let id = self.companyId {
            self.view?.isLoading(true)
            self.interactor.getCompany(companyId: id)
        } else {
            self.view?.showError(error: "No company id")
        }
    }
}

extension ShareDetailPresenter: ShareDetailInteractorOutputInterface {

    func getCompanySuccess(company: CompanyModel?) {
        self.view?.setCompany(company: company)
        self.view?.isLoading(false)
    }
    
    func getCompanyError(error: String) {
        self.view?.showError(error: error)
        self.view?.isLoading(false)
    }
    
}
