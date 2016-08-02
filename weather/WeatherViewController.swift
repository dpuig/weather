//
//  WeatherViewController.swift
//  weather
//
//  Created by Daniel Puig on 5/17/16.
//  Copyright © 2016 Daniel Puig. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    
    var appDelegate: AppDelegate =  UIApplication.sharedApplication().delegate as! AppDelegate

    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var weekDay: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var imageIconWeather: UIImageView!
    
    @IBOutlet weak var weatherDescrip: UILabel!
    
    @IBOutlet weak var humiLabel: UILabel!
    
    @IBOutlet weak var hLabel: UILabel!
    
    @IBOutlet weak var lLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        
        
        

        // Do any additional setup after loading the view.
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    override func viewWillAppear(animated: Bool) {
        let conditionId = String(self.appDelegate.selectedDayWeather!.icon!.characters.prefix(2))
        switch conditionId {
        case "01":
            self.headView.backgroundColor = UIColorFromHex(0x00C3E4,alpha: 1)//done
            self.view.backgroundColor = UIColorFromHex(0x00B5DD,alpha: 1)
            break;
        case "50":
            self.headView.backgroundColor = UIColorFromHex(0x90caf9,alpha: 1)//done
            self.view.backgroundColor = UIColorFromHex(0x90caf9,alpha: 1)
            break;
        case "02":
            self.headView.backgroundColor = UIColorFromHex(0x017B90,alpha: 1)//done
            self.view.backgroundColor = UIColorFromHex(0x006075,alpha: 1)
            break;
        case "03":
            self.headView.backgroundColor = UIColorFromHex(0x00ADC8,alpha: 1)//done
            self.view.backgroundColor = UIColorFromHex(0x0099BC,alpha: 1)
            break;
        case "04":
            self.headView.backgroundColor = UIColorFromHex(0x004451,alpha: 1)//done
            self.view.backgroundColor = UIColorFromHex(0x0002B34,alpha: 1)
            break;
        case "09":
            self.headView.backgroundColor = UIColorFromHex(0x004451,alpha: 1)//done
            self.view.backgroundColor = UIColorFromHex(0x002B34,alpha: 1)
            break;
        case "10":
            self.headView.backgroundColor = UIColorFromHex(0x0490AC,alpha: 1)//done
            self.view.backgroundColor = UIColorFromHex(0x8027A96, alpha: 1)
            break;
        case "11":
            self.headView.backgroundColor = UIColorFromHex(0x004755,alpha: 1)//done
            self.view.backgroundColor = UIColorFromHex(0x004755,alpha: 1)
            break;
        case "13":
            self.headView.backgroundColor = UIColorFromHex(0x1565c0,alpha: 1)//done
            self.view.backgroundColor = UIColorFromHex(0x0277bd,alpha: 1)
            break;
        default:
            self.view.backgroundColor = UIColorFromHex(0x7E827A,alpha: 1)
        }
        
        
        self.weekDay.text = getDayOfWeek(self.appDelegate.selectedDayWeather!.date!)
        
        let dateFormatter = NSDateFormatter()
        let theDateFormat = NSDateFormatterStyle.MediumStyle
        dateFormatter.dateStyle = theDateFormat
        let dateWeather: NSDate = self.appDelegate.selectedDayWeather!.date!
        self.dateLabel.text = "\(dateFormatter.stringFromDate(dateWeather))"
        
        let temp: Float = self.appDelegate.selectedDayWeather!.temperature.maxTemp!
        self.tempLabel.text = "\(String(Int(round(temp))))°"
        
        self.cityLabel.text = self.appDelegate.selectedDayWeather?.location?.city
        
        let icon = UIImage(named:"\((self.appDelegate.selectedDayWeather?.icon!)! as String)")
        self.imageIconWeather.image = icon;
        
        let desc: String = (self.appDelegate.selectedDayWeather?.main)!
        self.weatherDescrip.text = desc
        
        let hum: Float = (self.appDelegate.selectedDayWeather?.currentCondition.humidity)!
        self.humiLabel.text = "Humidity : \(String(Int(round(hum))))%"
        
        let h: Float = (self.appDelegate.selectedDayWeather?.temperature.maxTemp)!
        
        let l: Float = (self.appDelegate.selectedDayWeather?.temperature.minTemp)!
        
        self.hLabel.text = "L : \(String(Int(round(h))))°"
        self.lLabel.text = "M : \(String(Int(round(l))))°"
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
