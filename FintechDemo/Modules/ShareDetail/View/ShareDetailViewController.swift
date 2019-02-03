//
//  ShareDetailViewController.swift
//  FintechDemo
//
//  Created by Eduardo Nieto on 03/02/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import UIKit
protocol ShareDetailViewControllerInterface {
    func setCompany(company: CompanyModel?)
    func showError(error: String)
    func isLoading(_ isLoading: Bool)
}

class ShareDetailViewController: BaseViewController {
    let presenter: ShareDetailPresenterInterface?

    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companySharePriceLabel: UILabel!
    
    @IBOutlet weak var companyDescriptionLabel: UILabel!
    var company: CompanyModel?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(nibName: String, bundle: Bundle?, presenter: ShareDetailPresenterInterface?) {
        self.presenter = presenter != nil ? presenter : nil
        super.init(nibName: nibName, bundle: bundle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        
        presenter?.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            presenter?.viewWillDisappepear()
        }
    }
    
    
    private func configureView() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = "Company Detail"

    }
}

extension ShareDetailViewController: ShareDetailViewControllerInterface {
    func setCompany(company: CompanyModel?) {
        self.company = company
        self.companyNameLabel.text = "(\(self.company?.ric ?? "")) \(self.company?.name ?? "") - \(self.company?.country ?? "")"
        self.companySharePriceLabel.text = "\(self.company?.sharePrice.formatNumber() ?? "")"
        self.companyDescriptionLabel.text = self.company?.descriptionString
    }
    
    func showError(error: String) {
        self.presentError(title: "Error", message: error, buttonTitle: "Accept")
    }
    
    func isLoading(_ isLoading: Bool) {
        if isLoading {
            self.loadSpinner(text: "Loading")
        } else {
            self.hideSpinner()
        }
    }
}
