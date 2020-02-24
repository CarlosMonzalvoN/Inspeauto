//
//  ClientModel.swift
//  AutoInspector
//
//  Created by Pedro Carlos Monzalvo Navarro on 23/02/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import Foundation

struct ClientModel: Decodable {
    var lastname : String?
    var name : String?
    var uid : String!
    var photoUrl : String?

    
    enum CodingKeys: String, CodingKey{
        case lastname = "apellido"
        case name = "nombre"
        case uid = "uid"
        case photoUrl = "photo"

    }
}
