//
//  DayWeatherViewCell.swift
//  weather
//
//  Created by Daniel Puig on 5/3/16.
//  Copyright © 2016 Daniel Puig. All rights reserved.
//

import Foundation
import UIKit

class DayWeatherViewCell: UITableViewCell {

    
    @IBOutlet weak var labelTemp: UILabel!
   
    @IBOutlet weak var labelTempMin: UILabel!
    @IBOutlet weak var weekDayLabel: UILabel!
    

    @IBOutlet weak var cardViewWeather: UIView!
    @IBOutlet weak var imageIconWeather: UIImageView!
    
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var weekBack: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        /*
        self.cardViewWeather.layer.cornerRadius = 7
        self.cardViewWeather.layer.borderWidth = 0.1
        self.cardViewWeather.layer.borderColor = UIColor.grayColor().CGColor
 */
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}