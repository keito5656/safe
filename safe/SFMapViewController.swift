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

    @IBOutlet weak var buttonBaseView: UIView!
    @IBOutlet weak var shelterButton: UIButton!
    @IBOutlet weak var map: MKMapView!
    var myAnno: MKPointAnnotation?
    var myShelAnno: MKPointAnnotation?

    
    var myLocationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureMap()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.map.removeAnnotations(map.annotations)
        loadShelterList()
        map.removeOverlays(map.overlays)
        configureLocation()


        let ud = NSUserDefaults.standardUserDefaults()
        // キーがidの値をとります。
        let value : AnyObject! = ud.objectForKey("shelter");
        if let value = value {
            self.shelterButton.setTitle(value as! String, forState: .Normal)
        }
    }
    
    //LocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 配列から現在座標を取得.
        let myLocations: NSArray = locations as NSArray
        let myLastLocation: CLLocation = myLocations.lastObject as! CLLocation
        let myLocation:CLLocationCoordinate2D = myLastLocation.coordinate
        
        // 縮尺.
        let myLatDist : CLLocationDistance = 750.0
        let myLonDist : CLLocationDistance = 750.0
        
        // Regionを作成.
        let myRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(myLocation, myLatDist, myLonDist);
        
        // MapViewに反映.
        map.setRegion(myRegion, animated: true)

        map.removeAnnotation(self.myAnno!)
        
        
        //経路探索
        let fromPlacemark = MKPlacemark(coordinate:myLocation, addressDictionary:nil)
        let toPlacemark = MKPlacemark(coordinate:(myShelAnno?.coordinate)!, addressDictionary:nil)
        let fromItem = MKMapItem(placemark:fromPlacemark);
        let toItem = MKMapItem(placemark:toPlacemark);

        let request = MKDirectionsRequest()
        request.source = fromItem
        request.destination = toItem
        request.requestsAlternateRoutes = true; //複数経路
        request.transportType = MKDirectionsTransportType.Walking
        
        let directions = MKDirections(request:request)
        directions.calculateDirectionsWithCompletionHandler { (response, error) -> Void in
            if let _ = error {
                return;
            }
            let route: MKRoute = response!.routes[0] as MKRoute
            self.map.addOverlay(route.polyline)
        }
        
        
    }
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let route: MKPolyline = overlay as! MKPolyline
        let routeRenderer = MKPolylineRenderer(polyline:route)
        routeRenderer.lineWidth = 3.0
        routeRenderer.strokeColor = UIColor.redColor()
        return routeRenderer
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
        pinView?.pinTintColor = UIColor.safe_yellowColor()
        let ud = NSUserDefaults()
        let value : AnyObject! = ud.objectForKey("shelter");
        if let value = value {
            let shelter:String = value as! String
            if (shelter == annotation.title!) {
                pinView?.pinTintColor = UIColor.safe_orangeColor()
            }
        }
        if let myAnno = self.myAnno {
            if myAnno.title == (pinView?.annotation?.title)! {
                pinView?.pinTintColor = UIColor.redColor()
            }
        }

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
                let ud = NSUserDefaults()
                let value : AnyObject! = ud.objectForKey("shelter");

                var subtitle: String = "避難所"
                if let value = value {
                    if name == value as! String {
                        subtitle = "あなたの設定した避難所"
                        addMyShelterPin(name, subtitle: subtitle, location: location)
                    }
                }
                addShelterPin(name, subtitle: subtitle, location: location)
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
        myLocationManager.distanceFilter = 50.0
        
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
        let location:CLLocation = CLLocation.init(latitude: myLat, longitude: myLon)
        addMyLocation("静岡市役所", subtitle: "", location: location)
    }
    
    func addShelterPin(title:String, subtitle:String, location:CLLocation) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        annotation.title = title
        annotation.subtitle = subtitle
        map.addAnnotation(annotation)
    }
    func addMyShelterPin(title:String, subtitle:String, location:CLLocation) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        annotation.title = title
        annotation.subtitle = subtitle
        map.addAnnotation(annotation)
        self.myShelAnno = annotation;
    }
    
    func addMyLocation(title:String, subtitle:String, location:CLLocation) {
        if let anno = self.myAnno {
            map.removeAnnotation(anno)
        }
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        annotation.title = title
        annotation.subtitle = subtitle
        self.myAnno = annotation
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
}
