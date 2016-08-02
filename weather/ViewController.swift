//
//  ViewController.swift
//  weather
//
//  Created by Daniel Puig on 5/2/16.
//  Copyright © 2016 Daniel Puig. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    //5162774
    var appDelegate: AppDelegate =  UIApplication.sharedApplication().delegate as! AppDelegate
    
    var weathers = [Weather]()
    

    @IBOutlet weak var tableView: UITableView!
   

 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.tableFooterView = UIView()
      
        /*
        NSUserDefaults.standardUserDefaults().removeObjectForKey("city");
        NSUserDefaults.standardUserDefaults().removeObjectForKey("cityId");
        NSUserDefaults.standardUserDefaults().synchronize();
 */

    }
    

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.Black
        nav?.tintColor = UIColor.whiteColor()
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        

        
        var city: String = String()
        var cityId: String = String()
        
        
        if(NSUserDefaults.standardUserDefaults().valueForKey("cityId") != nil){
            city = NSUserDefaults.standardUserDefaults().valueForKey("city") as! String
            cityId = NSUserDefaults.standardUserDefaults().valueForKey("cityId") as! String
    
        } else {
            city = "Miami-Dade County"
            cityId = "4164238"

        }
        
        
        
        let _Services = Services(city: city, cityId:  cityId)
        _Services.getDailyForecast{(weathers) -> () in
            self.weathers = weathers
            self.tableView?.reloadData()
            self.appDelegate.selectedDayWeather = self.weathers[0]
            self.title = self.weathers[0].location!.city
            
            
        }
    }
    

    /*
    @IBAction func Settings(sender: AnyObject) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Right, animated: true, completion: nil)
    }
 */

  
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.weathers.count
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let weatherCard = tableView.dequeueReusableCellWithIdentifier("DayWeatherViewCell", forIndexPath: indexPath) as! DayWeatherViewCell
        
        let conditionId = String(self.weathers[indexPath.row].icon!.characters.prefix(2))
        switch conditionId {
        case "01":
            weatherCard.weekBack.backgroundColor = UIColorFromHex(0x00C3E4,alpha: 1)//done
            weatherCard.cardViewWeather.backgroundColor = UIColorFromHex(0x00B5DD,alpha: 1)
            break;
        case "50":
            weatherCard.weekBack.backgroundColor = UIColorFromHex(0x90caf9,alpha: 1)//done
            weatherCard.cardViewWeather.backgroundColor = UIColorFromHex(0x90caf9,alpha: 1)
            break;
        case "02":
            weatherCard.weekBack.backgroundColor = UIColorFromHex(0x017B90,alpha: 1)//done
            weatherCard.cardViewWeather.backgroundColor = UIColorFromHex(0x006075,alpha: 1)
            break;
        case "03":
            weatherCard.weekBack.backgroundColor = UIColorFromHex(0x00ADC8,alpha: 1)//done
            weatherCard.cardViewWeather.backgroundColor = UIColorFromHex(0x0099BC,alpha: 1)
            break;
        case "04":
            weatherCard.weekBack.backgroundColor = UIColorFromHex(0x004451,alpha: 1)//done
            weatherCard.cardViewWeather.backgroundColor = UIColorFromHex(0x0002B34,alpha: 1)
            break;
        case "09":
            weatherCard.weekBack.backgroundColor = UIColorFromHex(0x004451,alpha: 1)//done
            weatherCard.cardViewWeather.backgroundColor = UIColorFromHex(0x002B34,alpha: 1)
            break;
        case "10":
            weatherCard.weekBack.backgroundColor = UIColorFromHex(0x0490AC,alpha: 1)//done
            weatherCard.cardViewWeather.backgroundColor = UIColorFromHex(0x8027A96, alpha: 1)
            break;
        case "11":
            weatherCard.weekBack.backgroundColor = UIColorFromHex(0x004755,alpha: 1)//done
            weatherCard.cardViewWeather.backgroundColor = UIColorFromHex(0x004755,alpha: 1)
            break;
        case "13":
            weatherCard.weekBack.backgroundColor = UIColorFromHex(0x1565c0,alpha: 1)//done
            weatherCard.cardViewWeather.backgroundColor = UIColorFromHex(0x0277bd,alpha: 1)
            break;
        default:
            weatherCard.cardViewWeather.backgroundColor = UIColorFromHex(0x7E827A,alpha: 1)
        }
        
        
        weatherCard.weekDayLabel.text = getDayOfWeek(self.weathers[indexPath.row].date!)
        
        let temp: Float = self.weathers[indexPath.row].temperature.maxTemp!
        let tempmin: Float = self.weathers[indexPath.row].temperature.minTemp!
        weatherCard.labelTemp.text = "\(String(Int(round(temp))))°"
        weatherCard.labelTempMin.text = "\(String(Int(round(tempmin))))°"
        
        /*
        let backname = String(self.weathers[indexPath.row].icon!.characters.prefix(2))
        let background = UIImage(named: "\(backname)n-color")
        weatherCard.imageBackground.image = background;
         */
 
        let icon = UIImage(named:"\(self.weathers[indexPath.row].icon! as String)")
        weatherCard.imageIconWeather.image = icon;
 

        let dateFormatter = NSDateFormatter()
        let theDateFormat = NSDateFormatterStyle.MediumStyle
        dateFormatter.dateStyle = theDateFormat
        let dateWeather: NSDate = self.weathers[indexPath.row].date!
        
        
        if(dateFormatter.stringFromDate(dateWeather) == dateFormatter.stringFromDate(NSDate())){
            weatherCard.labelDate.text = "Today"
        } else {
            weatherCard.labelDate.text = "\(dateFormatter.stringFromDate(dateWeather))"
        }
        
       
        
        /*
        let dateFormatter = NSDateFormatter()//3
        
        var theDateFormat = NSDateFormatterStyle.MediumStyle //5
        let theTimeFormat = NSDateFormatterStyle.ShortStyle//6
        
        dateFormatter.dateStyle = theDateFormat//8
        dateFormatter.timeStyle = theTimeFormat//9
        
        let dateWeather: NSDate = self.weathers[indexPath.row].date!
        weatherCard.labelDate.text = "\(dateFormatter.stringFromDate(dateWeather))"
        
        */

        

        
        return weatherCard
    
    }
    
    func getDayOfWeek(date:NSDate)->String? {
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let myComponents = myCalendar.components(.Weekday, fromDate: date)
        let weekDay = myComponents.weekday
        switch weekDay {
        case 1:
            return "Sun"
        case 2:
            return "Mon"
        case 3:
            return "Tue"
        case 4:
            return "Wed"
        case 5:
            return "Thu"
        case 6:
            return "Fri"
        case 7:
            return "Sat"
        default:
            print("Error fetching days")
            return "Day"
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        appDelegate.selectedDayWeather = nil
        appDelegate.selectedDayWeather = self.weathers[indexPath.row]
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Right, animated: true, completion: nil)
    }
    
    @IBAction func Settings(sender: AnyObject) {
        let settingsView =  self.storyboard?.instantiateViewControllerWithIdentifier("SettingsTableViewController") as! SettingsTableViewController
        self.presentViewController(settingsView, animated: true, completion: nil)
    }



}

