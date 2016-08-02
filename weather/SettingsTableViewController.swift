//
//  SettingsTableViewController.swift
//  weather
//
//  Created by Daniel Puig on 5/20/16.
//  Copyright © 2016 Daniel Puig. All rights reserved.
//

import UIKit

class SettingsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate{
    
    var cities = [String: AnyObject]()
    var locations = [Location]()
    var filtlocations = [Location]()
    

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var searchActive : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Set the city"
        
        /* Setup delegates */
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self

        
       
        if let json = loadJson("citiesus")! as? [String: AnyObject] {
            
            for dict in json["cities"] as! [[String: AnyObject]]{
                let loc = Location()
                loc.city = dict["name"] as? String
                loc.cityId = dict["_id"] as? Int
                loc.country = dict["country"] as? String
                self.locations.append(loc)
            }
            
            self.locations.sortInPlace({ $0.city < $1.city })
       
            
            self.tableView?.reloadData()
            
        }
        
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.filtlocations = self.locations.filter({ (loc: Location) -> Bool in
            let tmp: Location = loc
            let range = tmp.city!.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return   (range != nil)
        })
        if(self.filtlocations.count == 0){
            self.searchActive = false;
        } else {
            self.searchActive = true;
        }
        self.tableView.reloadData()
    }

    
    
    func loadJson(fileName: String) -> [String: AnyObject]? {
        if let url = NSBundle.mainBundle().URLForResource(fileName, withExtension: "json") {
            if let data = NSData(contentsOfURL: url) {
                do {
                    let object = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                    if let dictionary = object as? [String: AnyObject] {
                        return dictionary
                    }
                } catch {
                    print("Error!! Unable to parse  \(fileName).json")
                }
            }
            print("Error!! Unable to load  \(fileName).json")
        }
        return nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(self.searchActive) {
            return self.filtlocations.count
        }
        return self.locations.count;
    
    
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell;
        if(searchActive){
            cell.textLabel?.text = "\(self.filtlocations[indexPath.row].city! as NSString), \(self.filtlocations[indexPath.row].country! as NSString)";
        } else {
            cell.textLabel?.text = "\(self.locations[indexPath.row].city! as  NSString), \(self.locations[indexPath.row].country! as  NSString)";
        }
        
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var city: String = String()
        var cityId: NSString = String()
        
   
        if(searchActive){
            city = self.filtlocations[indexPath.row].city!
            cityId = String(self.filtlocations[indexPath.row].cityId!)
        } else {
            city = self.locations[indexPath.row].city!
            cityId = "\(self.locations[indexPath.row].cityId!)"
        }
        NSUserDefaults.standardUserDefaults().setObject(city, forKey: "city");
        NSUserDefaults.standardUserDefaults().setObject(cityId, forKey: "cityId");
        NSUserDefaults.standardUserDefaults().synchronize();
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    



}
