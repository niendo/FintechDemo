//
//  ShareListInteractor.swift
//  FintechDemo
//
//  Created by Eduardo Nieto on 03/02/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
import ObjectMapper

protocol ShareListInteractorInputInterface {
    func getCompanies()
}

protocol ShareListInteractorOutputInterface: class{
    func getCompaniesSuccess(companies: [CompanyModel]?)
    func getCompaniesError(error: String)
}

class ShareListInteractor {
    
    let shareListDatasource: ShareListDataSourceInterface
    weak var interactorOutput: ShareListInteractorOutputInterface?
    
    init(shareListDatasource: ShareListDataSourceInterface) {
        self.shareListDatasource = shareListDatasource
    }
}

extension ShareListInteractor: ShareListInteractorInputInterface {
    
    func getCompanies() {
        
        
        if !Reachability.isConnectedToNetwork(){
            
            self.interactorOutput?.getCompaniesError(error: "NO INTERNET CONNECTION")
            
        } else {
            self.shareListDatasource.getCompaniesFromService(){  [weak self] (response, error) in
                
                if response != nil {
                    if let companiesNetworkOutput = Mapper<CompanyModel>().mapArray(JSONObject
                        : response?.response) {
                        
                        self?.interactorOutput?.getCompaniesSuccess(companies: self?.orderCompaniesByStockPrice(companies: companiesNetworkOutput))
                        
                    } else {
                        self?.interactorOutput?.getCompaniesError(error: "JSON FORMAT UNKOWN")
                    }
                } else if error != nil {
                    self?.interactorOutput?.getCompaniesError(error: error?.localizedDescription ?? "")
                    
                } else {
                    self?.interactorOutput?.getCompaniesError(error: "UNKNOWN ERROR")
                    
                }
            }
        }
        
    
    }
    
    private func orderCompaniesByStockPrice(companies: [CompanyModel]) -> [CompanyModel] {
        return companies.sorted(by: { $0.sharePrice > $1.sharePrice})

    }
    
}
