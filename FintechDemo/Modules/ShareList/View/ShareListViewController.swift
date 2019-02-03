//
//  ShareListViewController.swift
//  FintechDemo
//
//  Created by Eduardo Nieto on 03/02/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import UIKit

protocol ShareListViewControllerInterface {
    func setCompanies(companies: [CompanyModel]?)
    func showError(error: String)
    func isLoading(_ isLoading: Bool)
}

class ShareListViewController: BaseViewController {

    let presenter: ShareListPresenterInterface?
    var companies: [CompanyModel]?
    
    @IBOutlet weak var companiesTableView: UITableView!
    
    required init?(coder aDecoder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }
    
    init(nibName: String, bundle: Bundle?, presenter: ShareListPresenterInterface?) {
        self.presenter = presenter != nil ? presenter : nil
        super.init(nibName: nibName, bundle: bundle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        presenter?.viewDidLoad()
    }
    
    private func configureView() {
        self.title = "Companies"
        let nib = UINib(nibName: "CompanyTableViewCell", bundle: nil)
        self.companiesTableView.register(nib, forCellReuseIdentifier: "companyCell")
    }
}

extension ShareListViewController: ShareListViewControllerInterface {
    func isLoading(_ isLoading: Bool) {
        if isLoading {
            self.loadSpinner(text: "Loading")
        } else {
            self.hideSpinner()
        }
    }
    
    func setCompanies(companies: [CompanyModel]?) {
        self.companies = companies
        self.companiesTableView.reloadData()
    }
    
    func showError(error: String) {
        self.presentError(title: "Error", message: error, buttonTitle: "Accept")
    }
}

extension ShareListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "companyCell") as! CompanyTableViewCell
        cell.nameLabel.text = "(\(companies?[indexPath.row].ric ?? "")) \(companies?[indexPath.row].name ?? "")"
        cell.sharePriceLabel.text = "\(companies?[indexPath.row].sharePrice.formatNumber() ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let companyId = companies?[indexPath.row].id {
            presenter?.goToDetail(companyId: companyId)
        } else {
            self.showError(error: "")
        }
    }
}
