//
//  Weather.swift
//  weather
//
//  Created by Daniel Puig on 5/3/16.
//  Copyright © 2016 Daniel Puig. All rights reserved.
//

import Foundation
import UIKit

class Weather: NSObject{
    var location: Location?;
    var currentCondition: CurrentCondition = CurrentCondition();
    var temperature : Temperature = Temperature();
    var wind : Wind = Wind();
    var rain : Rain = Rain();
    var snow : Snow = Snow();
    var clouds : Clouds = Clouds();
    var date: NSDate?
    var main: String?
    var _description : String?
    var icon: String?
    
    var iconData: [UInt8]?;
    
    override init(){
    }
    
    class CurrentCondition: NSObject{
        
        var weatherId: Int?;
        var condition: String?;
        var descr: String?;
        var icon: String?;
        
        
        var pressure: Float?;
        var humidity: Float?;
    }
    
    class Temperature : NSObject {
        var temp: Float?;
        var minTemp: Float?;
        var maxTemp: Float?;
    }
    
    class Wind: NSObject {
        var speed : Float?;
        var deg : Float?;
    }
    
    class Rain: NSObject {
        var time : String?;
        var ammount: Float?;
    }
    
    class Snow: NSObject  {
        var time : String?;
        var ammount: Float?;
    }
    
    class Clouds: NSObject {
        var perc: Int?;
    }
    
    
    
    
}