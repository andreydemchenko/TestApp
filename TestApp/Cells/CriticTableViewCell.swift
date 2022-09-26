//
//  CriticCollectionViewCell.swift
//  TestApp
//
//  Created by andreydem on 26.09.2022.
//

import UIKit

class CriticTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    
    func setup(with critic: CriticModel) {
        nameLbl.text = critic.display_name
    }
}
