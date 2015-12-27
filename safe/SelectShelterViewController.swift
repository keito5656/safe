//
//  SelectShelterViewController.swift
//  safe
//
//  Created by 山本洸希 on 2015/12/13.
//  Copyright © 2015年 keito5656. All rights reserved.
//

import UIKit
import MapKit

class SelectShelterViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    struct shelterStruct {
        var name: String?
        var latitude:NSNumber
        var longitude:NSNumber
        var id:NSNumber
        var distance:Double
    }
    internal var centerLocation:CLLocationCoordinate2D!
    
    var shelters:[shelterStruct] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadShelterList()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return "避難所を選択してください"
        }
        let shelter:shelterStruct = shelters[row-1]
        return shelter.name
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return shelters.count+1
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if row == 0 {
            return
        }
        let ud = NSUserDefaults.standardUserDefaults()
        let shelter:shelterStruct = shelters[row-1]
        ud.setObject(shelter.name, forKey: "shelter")
        ud.synchronize()
    }
    
    func loadShelterList() {
        let path : String = NSBundle.mainBundle().pathForResource("ShelterList", ofType: "json")!
        let fileHandle : NSFileHandle = NSFileHandle(forReadingAtPath: path)!
        let data : NSData = fileHandle.readDataToEndOfFile()
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
            let shelterList:NSArray = json["features"] as! NSArray
            for shelter in shelterList {
                let coordinates = shelter["geometry"]??["coordinates"]
                let long:NSNumber = (coordinates!![0] as? NSNumber)!
                let lat:NSNumber  = (coordinates!![1] as? NSNumber)!
                let name:String = shelter["properties"]!!["name"] as! String
                let id:NSNumber      = shelter["properties"]!!["OBJECTID"] as! NSNumber
                let distance = pow(centerLocation.longitude-long.doubleValue, 2) + pow(centerLocation.latitude-lat.doubleValue, 2)
                let entry = shelterStruct(name: name, latitude: lat, longitude: long, id: id, distance: distance)

                
                shelters.append(entry)
            }
            shelters.sortInPlace({ (sht1, sht2) -> Bool in
                return sht1.distance < sht2.distance
            })
        } catch {
        }
    }
}
