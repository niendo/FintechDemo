//
//  ShareDetailInteractor.swift
//  FintechDemo
//
//  Created by Eduardo Nieto on 03/02/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
import ObjectMapper
protocol ShareDetailInteractorInputInterface {
    func getCompany(companyId: Int)
}

protocol ShareDetailInteractorOutputInterface: class{
    func getCompanySuccess(company: CompanyModel?)
    func getCompanyError(error: String)
}

class ShareDetailInteractor {
    
    let shareDetailDatasource: ShareDetailDataSourceInterface
    weak var interactorOutput: ShareDetailInteractorOutputInterface?
    
    init(shareDetailDatasource: ShareDetailDataSourceInterface) {
        self.shareDetailDatasource = shareDetailDatasource
    }
}

extension ShareDetailInteractor: ShareDetailInteractorInputInterface {
    
    func getCompany(companyId: Int) {
        
        if !Reachability.isConnectedToNetwork(){
            
            self.interactorOutput?.getCompanyError(error: "NO INTERNET CONNECTION")
            
        }else{
            self.shareDetailDatasource.getCompany(companyId: companyId){  [weak self] (response, error) in
                
                if response != nil {
                    if let companyNetworkOutput = Mapper<CompanyModel>().map(JSONObject
                        : response?.response) {
                        
                        self?.interactorOutput?.getCompanySuccess(company: companyNetworkOutput)
                        
                    } else {
                        self?.interactorOutput?.getCompanyError(error: "JSON FORMAT UNKNOWN")
                    }
                } else if error != nil {
                    self?.interactorOutput?.getCompanyError(error: error?.localizedDescription ?? "")

                } else {
                    self?.interactorOutput?.getCompanyError(error: "UNKNOWN ERROR")

                }
            }
        }
    }
    
}
