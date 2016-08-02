//
//  Services.swift
//  weather
//
//  Created by Daniel Puig on 5/3/16.
//  Copyright © 2016 Daniel Puig. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation


class Services : NSObject {
    var server: String = "http://api.openweathermap.org/data/2.5/"
    var APPID: String = "d1d6c8c0beb325ed5beb48b4af9811a0"
    var units: String = "imperial" //metric
    var city: String?
    var cityId: String?
    
    init(city: String, cityId:String){
        self.city = city
        self.cityId = cityId
        
    }
    
    internal func getForecast(completionHandler: ([Weather]) -> ()){
     
        let _url = NSURL(string: "\(self.server)forecast/city?id=\(self.cityId)&APPID=\(self.APPID)&units=imperial");
        
        let request = NSMutableURLRequest(URL: _url!);
        request.HTTPMethod = "GET"
        NSURLSession.sharedSession().dataTaskWithRequest(request){ (data, response, error) -> Void in
            if error != nil {
                print(error)
                return
            }
            
            do{
                let json = try(NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers))
                var weathers = [Weather]()
                
                for dict in json["list"] as! [[String: AnyObject]]{
                    let weather = Weather()
                    weather.location = Location()
                    weather.location?.longitude = json["city"]!!["coord"]!!["lon"] as? Float
                    weather.location?.latitude = json["city"]!!["coord"]!!["lat"] as? Float
                    weather.location?.city = json["city"]!!["name"] as? String
                    weather.location?.country = json["city"]!!["country"] as? String
                    
                    weather.temperature.temp = dict["main"]!["temp"] as? Float
                    
                    for wdet in dict["weather"] as! [[String: AnyObject]]{
                    weather.main = wdet["main"] as? String
                    weather.main = wdet["description"] as? String
                    
                    weather.icon = wdet["icon"] as? String
                 
                    
                    }
                    
                    let dateString = dict["dt_txt"]! as? String
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    weather.date = dateFormatter.dateFromString(dateString!)
                    print(weather.date)
                    
                    
                    weathers.append(weather)
                    
                }
                
                print(weathers.count)
                
                dispatch_async(dispatch_get_main_queue(), {() -> Void in
                    completionHandler(weathers)
                })
            } catch let err {
                print(err)
            }
            }.resume()
    }
    
    internal func getDailyForecast(completionHandler: ([Weather]) -> ()){
       
        let _url = NSURL(string: "\(self.server)forecast/daily?id=\(self.cityId! as String)&mode=json&cnt=7&APPID=\(self.APPID)&units=imperial");
       
        let request = NSMutableURLRequest(URL: _url!);
        request.HTTPMethod = "GET"
        NSURLSession.sharedSession().dataTaskWithRequest(request){ (data, response, error) -> Void in
            if error != nil {
                print(error)
                return
            }
            
            do{
                let json = try(NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers))
                var weathers = [Weather]()
                

                
                for dict in json["list"] as! [[String: AnyObject]]{
                    let weather = Weather()
                    weather.location = Location()
                    weather.location?.city = json["city"]!!["name"] as? String

                    let timeStamp = dict["dt"]! as? Double
                    weather.date = NSDate(timeIntervalSince1970: timeStamp!)
                    weather.temperature.maxTemp = dict["temp"]!["max"] as? Float
                    weather.temperature.minTemp = dict["temp"]!["min"] as? Float
                    
                    for wdet in dict["weather"] as! [[String: AnyObject]]{
                        weather.main = wdet["main"] as? String
                        weather._description = wdet["description"] as? String
                        
                        weather.icon = wdet["icon"] as? String
                        
                        
                    }
                    weather.currentCondition.humidity = dict["humidity"] as? Float
                    
                    //let calendar = NSCalendar.currentCalendar()
                    //let hour = calendar.component(NSCalendarUnit.Hour, fromDate: weather.date!)
                    
                    
                    weathers.append(weather)
                    
                }
                
                print(weathers.count)
                
                dispatch_async(dispatch_get_main_queue(), {() -> Void in
                    completionHandler(weathers)
                })
            } catch let err {
                print(err)
            }
            }.resume()
        
        
    }
    
}