//
//  CompanyNetworkOutput.swift
//  FintechDemo
//
//  Created by Eduardo Nieto on 03/02/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
import ObjectMapper

class CompanyModel: NSObject, Mappable {
    var id: Int = 0
    var name: String?
    var ric: String?
    var sharePrice: Float = 0.0
    var descriptionString: String?
    var country: String?

    public required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        id <- map [NetworkConstants.Output.id]
        name <- map [NetworkConstants.Output.name]
        ric <- map [NetworkConstants.Output.ric]
        sharePrice <- map [NetworkConstants.Output.sharePrice]
        descriptionString <- map [NetworkConstants.Output.description]
        country <- map [NetworkConstants.Output.country]
    }
    
    
}
