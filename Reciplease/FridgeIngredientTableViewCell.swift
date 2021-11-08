//
//  FridgeIngredientTableViewCell.swift
//  Reciplease
//
//  Created by Greg on 08/11/2021.
//

import UIKit

class FridgeIngredientTableViewCell: UITableViewCell {

    @IBOutlet private weak var ingredientTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(ingredient: String) {
        ingredientTitleLabel.text = ingredient
    }

}
