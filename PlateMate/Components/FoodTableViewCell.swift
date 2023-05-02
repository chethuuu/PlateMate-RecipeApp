//
//  FoodTableViewCell.swift
//  PlateMate
//
//  Created by Chethana on 2023-04-11.
//

import UIKit

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
