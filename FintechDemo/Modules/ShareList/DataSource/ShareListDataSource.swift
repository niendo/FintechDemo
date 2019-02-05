//
//  ShareListDataSource.swift
//  FintechDemo
//
//  Created by Eduardo Nieto on 03/02/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
protocol ShareListDataSourceInterface {
    func getCompaniesFromService(handle: @escaping ServiceHandler)
}

class ShareListDataSource: ServiceConnectionHelper {
    var getCompaniesUrl: String {
        return "https://dev.ninetynine.com/testapi/1/companies"
    }
    

}
extension ShareListDataSource: ShareListDataSourceInterface {
    func getCompaniesFromService(handle: @escaping ServiceHandler) {
        makePetition(urlString: getCompaniesUrl, method: HttpPetitionMethod.get.stringify(), headers: nil, params: nil, handle: handle)
    }
    

 
}
