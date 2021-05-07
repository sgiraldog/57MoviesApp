//
//  FavoriteTableViewCell.swift
//  MovieApp
//
//  Created by Sebastián Giraldo Gómez on 7/05/21.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    @IBOutlet weak var favoriteNameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    static let identifier = "FavoriteTableViewCell"

    static var nib: UINib {
           return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
