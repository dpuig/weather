//
//  Location.swift
//  weather
//
//  Created by Daniel Puig on 5/3/16.
//  Copyright © 2016 Daniel Puig. All rights reserved.
//

import Foundation
import UIKit

class Location: NSObject{
    var longitude: Float?
    var latitude: Float?
    var sunset: UInt32?;
    var sunrise: UInt32?;
    var country: String?;
    var city: String?;
    var cityId: Int?;
    
}