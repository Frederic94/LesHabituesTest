//
//  ShopCell.swift
//  LesHabituesTest
//
//  Created by Frederic Mallet on 03/02/2019.
//  Copyright © 2019 Frederic Mallet. All rights reserved.
//

import UIKit

class ShopCell: UITableViewCell {
    @IBOutlet weak var logoImageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.font = FontFamily.Lato.regular.font(size: 14.0)
            nameLabel.textColor = UIColor.cornflowerBlue
        }
    }
    @IBOutlet weak var adressLabel: UILabel! {
        didSet {
            adressLabel.font = FontFamily.Lato.regular.font(size: 14.0)
            adressLabel.textColor = UIColor.cornflowerBlue
        }
    }

    @IBOutlet weak var offerLabel: UILabel! {
        didSet {
            offerLabel.font = FontFamily.Lato.regular.font(size: 14.0)
            offerLabel.textColor = UIColor.cornflowerBlue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func configure(logo: UIImage, name: String, adress: String, offer: String) {
        logoImageView.image = logo
        nameLabel.text = name
        adressLabel.text = adress
        offerLabel.text = offer
    }
    
}
