//
//  AutomobileModel.swift
//  AutoInspector
//
//  Created by Pedro Carlos Monzalvo Navarro on 21/02/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import Foundation

struct AutomobileModel: Decodable {
    var brand : String?
    var distance : String?
    var license_plate : String?
    var model : String?
    var photoUrl : String?
    var uid : String!
    var year : String?
    var status : String?
    
    enum CodingKeys: String, CodingKey{
        case brand = "brand"
        case distance = "distance"
        case license_plate = "license_plate"
        case model = "model"
        case photoUrl = "photo"
        case uid = "uid"
        case year = "year"
        case status = "status"
    }
}
