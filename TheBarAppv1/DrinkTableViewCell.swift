//
//  DrinkTableViewCell.swift
//  TheBarAppv1
//
//  Created by Vuyo Matiti on 2021/07/17.
//

import UIKit

class DrinkTableViewCell: UITableViewCell {
    @IBOutlet weak var drinkView: UIView!
    
 
   // @IBOutlet weak var drinkType: UILabel!
    //@IBOutlet weak var drinkCategory: UILabel!
    @IBOutlet weak var drinkCategory: UILabel!
    @IBOutlet weak var drinkType: UILabel!
    @IBOutlet weak var drinkName: UILabel!
    @IBOutlet weak var drinkImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
