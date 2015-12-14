//
//  SFMapViewController.swift
//  safe
//
//  Created by 山本洸希 on 2015/12/13.
//  Copyright © 2015年 keito5656. All rights reserved.
//

import UIKit
import MapKit
let distance:CLLocationDistance = 2000

class SFMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    var myLocationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLocation()
        configureMap()
        
        loadShelterList()
    }
    
    //LocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 配列から現在座標を取得.
        let myLocations: NSArray = locations as NSArray
        let myLastLocation: CLLocation = myLocations.lastObject as! CLLocation
        let myLocation:CLLocationCoordinate2D = myLastLocation.coordinate
        
        // 縮尺.
        let myLatDist : CLLocationDistance = distance
        let myLonDist : CLLocationDistance = distance
        
        // Regionを作成.
        let myRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(myLocation, myLatDist, myLonDist);
        
        // MapViewに反映.
        map.setRegion(myRegion, animated: true)
    }
    
    // MapViewDelegate
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.animatesDrop = true
        }
        else {
            pinView?.annotation = annotation
        }
        pinView?.canShowCallout = true

        return pinView
    }
    
    // private
    
    func loadShelterList() {
        let path : String = NSBundle.mainBundle().pathForResource("ShelterList", ofType: "json")!
        let fileHandle : NSFileHandle = NSFileHandle(forReadingAtPath: path)!
        let data : NSData = fileHandle.readDataToEndOfFile()

        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
            let shelterList:NSArray = json["features"] as! NSArray
            for shelter in shelterList {
                let coordinates = shelter["geometry"]!!["coordinates"]
                let long:NSNumber = (coordinates!![0] as? NSNumber)!
                let lat:NSNumber  = (coordinates!![1] as? NSNumber)!
                let name:String = shelter["properties"]!!["name"] as! String
                let location:CLLocation = CLLocation.init(latitude: lat.doubleValue, longitude: long.doubleValue)
                addShelterPin(name, subtitle: "避難所", location: location)
            }
            
        } catch {
        }
    }
    
    func configureLocation() {
        // LocationManagerの生成.
        myLocationManager = CLLocationManager()
        
        // Delegateの設定.
        myLocationManager.delegate = self
        
        // 距離のフィルタ.
        myLocationManager.distanceFilter = 100.0
        
        // 精度.
        myLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        // セキュリティ認証のステータスを取得.
        let status = CLLocationManager.authorizationStatus()
        
        // まだ認証が得られていない場合は、認証ダイアログを表示.
        if(status == CLAuthorizationStatus.NotDetermined) {
            
            // まだ承認が得られていない場合は、認証ダイアログを表示.
            self.myLocationManager.requestAlwaysAuthorization();
        }
        
        // 位置情報の更新を開始.
        myLocationManager.startUpdatingLocation()

    }
    
    func configureMap() {
        // 中心点の緯度経度.
        let myLat: CLLocationDegrees = 34.976978
        let myLon: CLLocationDegrees = 138.383054
        let myCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLat, myLon) as CLLocationCoordinate2D
        
        // 縮尺.
        let myLatDist : CLLocationDistance = distance
        let myLonDist : CLLocationDistance = distance
        
        // Regionを作成.
        let myRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(myCoordinate, myLatDist, myLonDist);
        // Delegateを設定.
        map.delegate = self
        // MapViewに反映.
        map.setRegion(myRegion, animated: true)
        
    }
    
    func addShelterPin(title:String, subtitle:String, location:CLLocation) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        annotation.title = title
        annotation.subtitle = subtitle
        annotation
        map.addAnnotation(annotation)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        let viewController:SelectShelterViewController = segue.destinationViewController as! SelectShelterViewController
        viewController.centerLocation = map.centerCoordinate
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
