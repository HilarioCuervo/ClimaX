//
//  FutureClimateCell.swift
//  ClimaX
//
//  Created by Hilario Cuervo on 31/12/2021.
//

import UIKit

class FutureClimateCell: UICollectionViewCell {
    
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 15.0
        viewCell.layer.cornerRadius = 15.0
        layer.masksToBounds = false
        viewCell.layer.masksToBounds = false
        
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = #colorLiteral(red: 0.1725490196, green: 0.1529411765, blue: 0.1803921569, alpha: 1)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 4
        
        layer.borderColor = #colorLiteral(red: 0.1725490196, green: 0.1529411765, blue: 0.1803921569, alpha: 1)
        layer.borderWidth = 0.75
    }

}
