//
//  ShareDetailDataSource.swift
//  FintechDemo
//
//  Created by Eduardo Nieto on 03/02/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
protocol ShareDetailDataSourceInterface {
    func getCompany(companyId: Int, handle: @escaping ServiceHandler)
}

class ShareDetailDataSource: ServiceConnectionHelper {
    var getCompanyUrl: String {
        return "https://dev.ninetynine.com/testapi/1/companies/"
    }
}
extension ShareDetailDataSource: ShareDetailDataSourceInterface {
    func getCompany(companyId: Int, handle: @escaping ServiceHandler) {
        makePetition(urlString: "\(getCompanyUrl)\(companyId)", method: HttpPetitionMethod.get.stringify(), headers: nil, params: nil, handle: handle, refresh: true)
    }
    
    
}
