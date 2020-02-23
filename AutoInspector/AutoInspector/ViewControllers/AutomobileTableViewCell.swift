//
//  AutomobileTableViewCell.swift
//  AutoInspector
//
//  Created by Pedro Carlos Monzalvo Navarro on 20/02/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import UIKit

class AutomobileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var automobileImage: UIImageView!
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var licensePlate: UILabel!
    
    static let identifier = "automobileCell"
    
    func updateCell(automobile : AutomobileModel){
        automobileImage.load(automobile.photoUrl ?? "")
        model.text = automobile.model
        year.text = automobile.year
        licensePlate.text = automobile.license_plate
    }
    
}
