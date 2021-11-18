//
//  RecipeListTableViewCell.swift
//  Reciplease
//
//  Created by Greg on 17/11/2021.
//

import UIKit

class RecipeListTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeLikesLabel: UILabel!
    @IBOutlet weak var recipeTimerLabel: UILabel!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeIngredientsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(ingredient: String) {

    }

}
