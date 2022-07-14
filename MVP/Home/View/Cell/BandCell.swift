//
//  BandCell.swift
//  MVP
//
//  Created by Marcelo Fernandez on 12/07/2022.
//

import Foundation

import Foundation
import UIKit

class BandCell: UITableViewCell {
    @IBOutlet weak var bandLogo: UIImageView!
    @IBOutlet weak var bandName: UILabel!
    
    static let identifier = "BandCell"
    
    func configureCellWith(model: Band) {
        if let logo = model.logo {
            bandLogo.load(url: logo)
        }
        bandName.text = model.name
    }
}
