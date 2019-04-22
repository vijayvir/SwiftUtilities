//
//  LocationManager.swift
//  FoodStrap
//
//  Created by Ajay Chaudhary on 11/02/18.
//  Copyright © 2016 Imvisile Solutions Pvt. Ltd. All rights reserved.
//
//<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
//<string>Location always and when in usage description</string>
//<key>NSLocationWhenInUseUsageDescription</key>
//<string>Location always usage description</string>

import UIKit
import CoreLocation
import MapKit

let GoogleAPIKeyLeo = "AIzaSyADZVfZWQbDVxfLSV2-R_Ym-BIzV_WoyeY"


typealias LMGeocodeCompletionHandler = ((_ gecodeInfo:NSDictionary?,_ placemark:CLPlacemark?, _ error:String?)->Void)?

typealias ClosureReverveGoogleGeoCodeType = ((_ geocodo:GeocodeGoogleIncoming?)->Void)?

typealias LMLocationCompletionHandler = ((_ latitude:Double, _ longitude:Double, _ status:String, _ verboseMessage:String, _ error:String?)->())?

// Todo: Keep completion handler differerent for all services, otherwise only one will work
enum GeoCodingType{
    case geocoding
    case reverseGeocoding
}
extension LeoLocationManager {
    
    func leoReverseGeocodeLocationUsingGoogle(_ coord:CLLocationCoordinate2D , onReverseGeocodingCompletionHandler:ClosureReverveGoogleGeoCodeType){
        reverseGeocodeLocationUsingGoogleWithLatLon(latitude: coord.latitude, longitude: coord.longitude, onReverseGeocodingCompletionHandler: onReverseGeocodingCompletionHandler)
    }
    func leoStartUpdatingLocationWithCompletionHandler(_ completionHandler:((_ latitude:Double, _ longitude:Double, _ status:String, _ verboseMessage:String, _ error:String?)->())? = nil){
        isRunning = true
        self.completisonHandler = completionHandler
        
        initLocationManager()
    }
    
}

class LeoLocationManager: NSObject,CLLocationManagerDelegate {
    
    enum Status : String {
        case  Allowed = "Allowed access"
        
//        case CLAuthorizationStatus.restricted:
//        locationStatus = "Restricted Access"
//        case CLAuthorizationStatus.denied:
//        locationStatus = "Denied access"
//        case CLAuthorizationStatus.notDetermined:
//        locationStatus = "Not determined"
//        default:
//        locationStatus = "Allowed access"
        
    }
    
    /* Private variables */
    
    fileprivate var completisonHandler:LMLocationCompletionHandler
    
    fileprivate var closureReverveGoogleGeoCode:ClosureReverveGoogleGeoCodeType
    
    fileprivate var geocodingCompletionHandler:LMGeocodeCompletionHandler
    
    
    var locationStatus : NSString = "Calibrating"// to pass in handler
    
    fileprivate var locationManager: CLLocationManager!
   
    fileprivate var verboseMessage = "Calibrating"

    fileprivate let verboseMessageDictionary = [
        CLAuthorizationStatus.notDetermined:"You have not yet made a choice with regards to this application.",
        CLAuthorizationStatus.restricted:"This application is not authorized to use location services. Due to active restrictions on location services, the user cannot change this status, and may not have personally denied authorization.",
        CLAuthorizationStatus.denied:"You have explicitly denied authorization for this application, or location services are disabled in Settings.",
        CLAuthorizationStatus.authorizedAlways:"App is Authorized to use location services.",
        CLAuthorizationStatus.authorizedWhenInUse:"You have granted authorization to use your location only when the app is visible to you."]
    
    
    var delegate:LocationManagerDelegate? = nil
    
    var latitude:Double = 0.0
    
    var longitude:Double = 0.0
    
    var latitudeAsString:String = ""
  
    var longitudeAsString:String = ""
    
    
    var lastKnownLatitude:Double = 0.0
    
    var lastKnownLongitude:Double = 0.0
    
    var lastKnownLatitudeAsString:String = ""
    
    var lastKnownLongitudeAsString:String = ""
    
    
    var keepLastKnownLocation:Bool = true
    
    var hasLastKnownLocation:Bool = true
    
    var autoUpdate:Bool = false
    
    var showVerboseMessage = false
    
    var isRunning = false
    
    
    class var sharedInstance : LeoLocationManager {
        struct Static {
            static let instance : LeoLocationManager = LeoLocationManager()

        }
        return Static.instance
        
    }
    
    
    fileprivate override init(){
        
        super.init()
        
        if(!autoUpdate){
            autoUpdate = !CLLocationManager.significantLocationChangeMonitoringAvailable()
        }
        
    }
    
    fileprivate func resetLatLon(){
        
        latitude = 0.0
        longitude = 0.0
        
        latitudeAsString = ""
        longitudeAsString = ""
        
    }
    
    fileprivate func resetLastKnownLatLon(){
        
        hasLastKnownLocation = false
        
        lastKnownLatitude = 0.0
        lastKnownLongitude = 0.0
        
        lastKnownLatitudeAsString = ""
        lastKnownLongitudeAsString = ""
        
    }
    

    
    func startUpdatingLocation(){
        
        initLocationManager()
    }
    
    func stopUpdatingLocation(){
       
        stopLocationManger()
        
        resetLatLon()
        if(!keepLastKnownLocation){
            resetLastKnownLatLon()
        }
    }
    
    fileprivate func initLocationManager() {
        
        // App might be unreliable if someone changes autoupdate status in between and stops it
        locationManager = CLLocationManager()
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        let device = UIDevice.current
        
        let iosVersion = NSString(string: device.systemVersion).doubleValue
        
        let iOS8 = iosVersion >= 8
        
        if iOS8{
            
        locationManager.requestWhenInUseAuthorization() // add in plist NSLocationWhenInUseUsageDescription
        }
        
        startLocationManger()
        
        
    }
    
    fileprivate func startLocationManger(){
        
        if(autoUpdate){
            
            locationManager.startUpdatingLocation()
        }else{
            
            locationManager.startMonitoringSignificantLocationChanges()
        }
        
        
    }
    
    
    fileprivate func stopLocationManger(){
        
        if(autoUpdate){
            locationManager.stopUpdatingLocation()
        }else{
            locationManager.stopMonitoringSignificantLocationChanges()
        }
        
        isRunning = false
    }
    
    
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        stopLocationManger()
        
        resetLatLon()
        
        if(!keepLastKnownLocation){
            
            resetLastKnownLatLon()
        }
        
        var verbose = ""
        if showVerboseMessage {verbose = verboseMessage}
        completisonHandler?(0.0, 0.0, locationStatus as String, verbose,error.localizedDescription)
        
        if ((delegate != nil) && (delegate?.responds(to: #selector(LocationManagerDelegate.locationManagerReceivedError(_:))))!){
            delegate?.locationManagerReceivedError!(error.localizedDescription as NSString)
        }
    }
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let arrayOfLocation = locations as NSArray
        let location = arrayOfLocation.lastObject as! CLLocation
        let coordLatLon = location.coordinate
        
        latitude  = coordLatLon.latitude
        longitude = coordLatLon.longitude
        
        latitudeAsString  = coordLatLon.latitude.description
        longitudeAsString = coordLatLon.longitude.description
        print("***************")
        print("coordinate",location.coordinate)
        print("altitude",location.altitude)
        print("horizontalAccuracy",location.horizontalAccuracy)
        print("verticalAccuracy",location.verticalAccuracy)
        print("course",location.course)
        print("speed",location.speed)
        print("timestamp",location.timestamp)
        print("floor",location.floor)
         print("distance",location.distance(from: location))
        var verbose = ""
        
        if showVerboseMessage {verbose = verboseMessage}
        
        lastKnownLatitude = coordLatLon.latitude
        lastKnownLongitude = coordLatLon.longitude
        
        lastKnownLatitudeAsString = coordLatLon.latitude.description
        lastKnownLongitudeAsString = coordLatLon.longitude.description
        
        hasLastKnownLocation = true
        
        if(completisonHandler != nil){
            
            completisonHandler?(latitude, longitude, locationStatus as String,verbose, nil)
        }
        
       
        
        if (delegate != nil){
            if((delegate?.responds(to: #selector(LocationManagerDelegate.locationFoundGetAsString(_:longitude:))))!){
                delegate?.locationFoundGetAsString!(latitudeAsString as NSString,longitude:longitudeAsString as NSString)
            }
            if((delegate?.responds(to: #selector(LocationManagerDelegate.locationFound(_:longitude:))))!){
                delegate?.locationFound(latitude,longitude:longitude)
            }
        }
    }
    
    
    internal func locationManager(_ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus) {
            var hasAuthorised = false
            let verboseKey = status
            switch status {
            case CLAuthorizationStatus.restricted:
                locationStatus = "Restricted Access"
            case CLAuthorizationStatus.denied:
                locationStatus = "Denied access"
            case CLAuthorizationStatus.notDetermined:
                locationStatus = "Not determined"
            default:
                locationStatus = "Allowed access"
                hasAuthorised = true
            }
            
            verboseMessage = verboseMessageDictionary[verboseKey]!
            
            if (hasAuthorised == true) {
                startLocationManger()
            }else{
                
                resetLatLon()
                if (!locationStatus.isEqual(to: "Denied access")){
                    
                    var verbose = ""
                    if showVerboseMessage {
                        
                        verbose = verboseMessage
                        
                        if ((delegate != nil) && (delegate?.responds(to: #selector(LocationManagerDelegate.locationManagerVerboseMessage(_:))))!){
                            
                            delegate?.locationManagerVerboseMessage!(verbose as NSString)
                            
                        }
                    }
                    
                    if(completisonHandler != nil){
                        completisonHandler?(latitude, longitude, locationStatus as String, verbose,nil)
                    }
                }
                if ((delegate != nil) && (delegate?.responds(to: #selector(LocationManagerDelegate.locationManagerStatus(_:))))!){
                    delegate?.locationManagerStatus!(locationStatus)
                }
            }
            
    }
    func reverseGeocodeLocationWith(coorditnate :CLLocationCoordinate2D ,onReverseGeocodingCompletionHandler:ClosureReverveGoogleGeoCodeType){
        
        let location:CLLocation = CLLocation(latitude:coorditnate.latitude, longitude: coorditnate.longitude)
        
        reverseGeocodeLocationWithCoordinates(location,completionHandler: onReverseGeocodingCompletionHandler)
        
    }
    
    func reverseGeocodeLocationWithLatLon(latitude:Double, longitude: Double,onReverseGeocodingCompletionHandler:ClosureReverveGoogleGeoCodeType){
        
        let location:CLLocation = CLLocation(latitude:latitude, longitude: longitude)
        
        reverseGeocodeLocationWithCoordinates(location,completionHandler: onReverseGeocodingCompletionHandler)
        
    }
    
    func reverseGeocodeLocationWithCoordinates(_ coord:CLLocation, completionHandler:ClosureReverveGoogleGeoCodeType){
        self.closureReverveGoogleGeoCode = completionHandler
        reverseGocode(coord)
    }
    
    fileprivate func reverseGocode(_ location:CLLocation){
        
        let geocoder: CLGeocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil) {
               // self.closureReverseGeocodingCompletionHandler!(nil,nil, error!.localizedDescription)
                
            }
            else{
                
                if let placemark = placemarks?.first {
                 //   let address = AddressParser()
                //    address.parseAppleLocationData(placemark)
                  //  let addressDict = address.getAddressDictionary()
                  //  self.closureReverseGeocodingCompletionHandler!(addressDict,placemark,nil)
                }
                else {
                 //   self.closureReverseGeocodingCompletionHandler!(nil,nil,"No Placemarks Found!")
                    return
                }
            }
            
        })
        
        
    }
    
    
    
    func geocodeAddressString(address:NSString, onGeocodingCompletionHandler:LMGeocodeCompletionHandler){
        
        self.geocodingCompletionHandler = onGeocodingCompletionHandler
        
        geoCodeAddress(address)
        
    }
    
    
    fileprivate func geoCodeAddress(_ address:NSString){
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address as String, completionHandler: {(placemarks, error) -> Void in
            if (error != nil) {
                
                self.geocodingCompletionHandler!(nil,nil,error!.localizedDescription)
                
            }
            else{
                
                if let placemark = placemarks?.first {
                    
                    let address = AddressParser()
                    address.parseAppleLocationData(placemark)
                    let addressDict = address.getAddressDictionary()
                    self.geocodingCompletionHandler!(addressDict,placemark,nil)
                }
                else {
                    
                    self.geocodingCompletionHandler!(nil,nil,"invalid address: \(address)")
                    
                }
            }
            
        })
        
//        geocoder.geocodeAddressString(address as String, completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
//            
//            
//            
//            
//            } as! CLGeocodeCompletionHandler)
//        
        
    }
    
    
    func geocodeUsingGoogleAddressString(address:NSString, onGeocodingCompletionHandler:LMGeocodeCompletionHandler){
        
        self.geocodingCompletionHandler = onGeocodingCompletionHandler
        
        geoCodeUsignGoogleAddress(address)
    }
    
    //
    //TODO: Need to change the Google KEY
    fileprivate func geoCodeUsignGoogleAddress(_ address:NSString){
        
        var urlString = "https://maps.googleapis.com/maps/api/geocode/json?address=\(address)&sensor=true&key=AIzaSyBtuTtqNTAfE-haJ1c0tAIjncId_OtdrV8" as NSString
        
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! as NSString
        
        performOperationForURL(urlString as String, type: GeoCodingType.geocoding)
        
    }
    
    func reverseGeocodeLocationUsingGoogleWithLatLon(latitude:Double, longitude: Double,onReverseGeocodingCompletionHandler:ClosureReverveGoogleGeoCodeType){
        
        self.closureReverveGoogleGeoCode = onReverseGeocodingCompletionHandler
        
        reverseGocodeUsingGoogle(latitude: latitude, longitude: longitude)
        
    }
    
    func reverseGeocodeLocationUsingGoogleWithCoordinates(_ coord:CLLocation, onReverseGeocodingCompletionHandler:ClosureReverveGoogleGeoCodeType){
        
        reverseGeocodeLocationUsingGoogleWithLatLon(latitude: coord.coordinate.latitude, longitude: coord.coordinate.longitude, onReverseGeocodingCompletionHandler: onReverseGeocodingCompletionHandler)
        
    }
    
 
    
    fileprivate func reverseGocodeUsingGoogle(latitude:Double, longitude: Double){
        
        let urlString : String = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(latitude),\(longitude)&sensor=true&key=\(GoogleAPIKeyLeo)"
    

        performOperationForURL(urlString, type: GeoCodingType.reverseGeocoding)
        
    }
    enum StatusGoogleApis : String {
        case ok = "OK"
        case ZERO_RESULTS = "ZERO_RESULTS"
        case OVER_QUERY_LIMIT = "OVER_QUERY_LIMIT"
        case REQUEST_DENIED = "REQUEST_DENIED"
        case INVALID_REQUEST = "INVALID_REQUEST"
        case Invalid_Input = "Invalid Input"
      
        
    }
    fileprivate func performOperationForURL(_ urlString:String,type:GeoCodingType){
        
        let url:URL? = URL(string:urlString as String)
        
        let request:URLRequest = URLRequest(url:url!)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            if(error != nil){
                
                self.setCompletionHandler(responseInfo:nil, placemark:nil, error:error!.localizedDescription, type:type)
                
            }else{
                do {
                    if let json  = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String :Any] {
                        
                        let some = GeocodeGoogleIncoming(dict: json ?? [:])
                        
                        if let status = some.status {
                            if status == StatusGoogleApis.ok.rawValue {
                                
                                self.closureReverveGoogleGeoCode?(some)
                            } else if status == StatusGoogleApis.ZERO_RESULTS.rawValue ||
                                status == StatusGoogleApis.OVER_QUERY_LIMIT.rawValue ||
                                status ==  StatusGoogleApis.REQUEST_DENIED.rawValue ||
                                status == StatusGoogleApis.INVALID_REQUEST.rawValue ||
                                status == StatusGoogleApis.Invalid_Input.rawValue {
                                
                                
                           
                                 self.closureReverveGoogleGeoCode?(some)
                                
                            }
                            
                          
                        }
                        
                        
                    }
                    
                    
                }catch {
                    print(error.localizedDescription)
                }
                

                
            }
            
        }) 
        
        task.resume()
        
    }
    
    fileprivate func setCompletionHandler(responseInfo:NSDictionary?,placemark:CLPlacemark?, error:String?,type:GeoCodingType){
        
        if(type == GeoCodingType.geocoding){
            
            self.geocodingCompletionHandler!(responseInfo,placemark,error)
            
        }else{
            
           // self.closureReverseGeocodingCompletionHandler!(responseInfo,placemark,error)
        }
    }
}


@objc protocol LocationManagerDelegate : NSObjectProtocol
{
    func locationFound(_ latitude:Double, longitude:Double)
    @objc optional func locationFoundGetAsString(_ latitude:NSString, longitude:NSString)
    @objc optional func locationManagerStatus(_ status:NSString)
    @objc optional func locationManagerReceivedError(_ error:NSString)
    @objc optional func locationManagerVerboseMessage(_ message:NSString)
}

private class AddressParser: NSObject{
    
    fileprivate var latitude = NSString()
    fileprivate var longitude  = NSString()
    fileprivate var streetNumber = NSString()
    fileprivate var route = NSString()
    fileprivate var locality = NSString()
    fileprivate var subLocality = NSString()
    fileprivate var formattedAddress = NSString()
    fileprivate var administrativeArea = NSString()
    fileprivate var administrativeAreaCode = NSString()
    fileprivate var subAdministrativeArea = NSString()
    fileprivate var postalCode = NSString()
    fileprivate var country = NSString()
    fileprivate var subThoroughfare = NSString()
    fileprivate var thoroughfare = NSString()
    fileprivate var ISOcountryCode = NSString()
    fileprivate var state = NSString()
    
    
    override init(){
        
        super.init()
        
    }
    
    fileprivate func getAddressDictionary()-> NSDictionary{
        
        let addressDict = NSMutableDictionary()
        
        addressDict.setValue(latitude, forKey: "latitude")
        addressDict.setValue(longitude, forKey: "longitude")
        addressDict.setValue(streetNumber, forKey: "streetNumber")
        addressDict.setValue(locality, forKey: "locality")
        addressDict.setValue(subLocality, forKey: "subLocality")
        addressDict.setValue(administrativeArea, forKey: "administrativeArea")
        addressDict.setValue(postalCode, forKey: "postalCode")
        addressDict.setValue(country, forKey: "country")
        addressDict.setValue(formattedAddress, forKey: "formattedAddress")
        
        return addressDict
    }
    
    
    fileprivate func parseAppleLocationData(_ placemark:CLPlacemark){
        
        let addressLines = placemark.addressDictionary!["FormattedAddressLines"] as! NSArray
        
        //self.streetNumber = placemark.subThoroughfare ? placemark.subThoroughfare : ""
        self.streetNumber = (placemark.thoroughfare != nil ? placemark.thoroughfare : "")! as NSString
        self.locality = (placemark.locality != nil ? placemark.locality : "")! as NSString
        self.postalCode = (placemark.postalCode != nil ? placemark.postalCode : "")! as NSString
        self.subLocality = (placemark.subLocality != nil ? placemark.subLocality : "")! as NSString
        self.administrativeArea = (placemark.administrativeArea != nil ? placemark.administrativeArea : "")! as NSString
        self.country = (placemark.country != nil ?  placemark.country : "")! as NSString
        self.longitude = placemark.location!.coordinate.longitude.description as NSString;
        self.latitude = placemark.location!.coordinate.latitude.description as NSString
        if(addressLines.count>0){
            self.formattedAddress = addressLines.componentsJoined(by: ", ") as NSString}
        else{
            self.formattedAddress = ""
        }
        
        
    }
    
    
    fileprivate func parseGoogleLocationData(_ resultDict:NSDictionary){
        
        let locationDict = (resultDict.value(forKey: "results") as! NSArray).firstObject as! NSDictionary
        
        let formattedAddrs = locationDict.object(forKey: "formatted_address") as! NSString
        
        let geometry = locationDict.object(forKey: "geometry") as! NSDictionary
        let location = geometry.object(forKey: "location") as! NSDictionary
        let lat = location.object(forKey: "lat") as! Double
        let lng = location.object(forKey: "lng") as! Double
        
        self.latitude = lat.description as NSString
        self.longitude = lng.description as NSString
        
        let addressComponents = locationDict.object(forKey: "address_components") as! NSArray
        
        self.subThoroughfare = component("street_number", inArray: addressComponents, ofType: "long_name")
        self.thoroughfare = component("route", inArray: addressComponents, ofType: "long_name")
        self.streetNumber = self.subThoroughfare
        self.locality = component("locality", inArray: addressComponents, ofType: "long_name")
        self.postalCode = component("postal_code", inArray: addressComponents, ofType: "long_name")
        self.route = component("route", inArray: addressComponents, ofType: "long_name")
        self.subLocality = component("subLocality", inArray: addressComponents, ofType: "long_name")
        self.administrativeArea = component("administrative_area_level_1", inArray: addressComponents, ofType: "long_name")
        self.administrativeAreaCode = component("administrative_area_level_1", inArray: addressComponents, ofType: "short_name")
        self.subAdministrativeArea = component("administrative_area_level_2", inArray: addressComponents, ofType: "long_name")
        self.country =  component("country", inArray: addressComponents, ofType: "long_name")
        self.ISOcountryCode =  component("country", inArray: addressComponents, ofType: "short_name")
        self.formattedAddress = formattedAddrs;
        
    }
    
    fileprivate func component(_ component:NSString,inArray:NSArray,ofType:NSString) -> NSString{
            let index = inArray.indexOfObject(passingTest:) {obj, idx, stop in
            let objDict:NSDictionary = obj as! NSDictionary
            let types:NSArray = objDict.object(forKey: "types") as! NSArray
            let type = types.firstObject as! NSString
            return type.isEqual(to: component as String)
         }
        
        if (index == NSNotFound){
            
            return ""
        }
        
        if (index >= inArray.count){
            return ""
        }
        
        let type = ((inArray.object(at: index) as! NSDictionary).value(forKey: ofType as String)!) as! NSString
        
        if (type.length > 0){
            
            return type
        }
        return ""
        
    }
    
    fileprivate func getPlacemark() -> CLPlacemark{
        
        var addressDict = [String : AnyObject]()
        
        let formattedAddressArray = self.formattedAddress.components(separatedBy: ", ") as Array
        
        let kSubAdministrativeArea = "SubAdministrativeArea"
        let kSubLocality           = "SubLocality"
        let kState                 = "State"
        let kStreet                = "Street"
        let kThoroughfare          = "Thoroughfare"
        let kFormattedAddressLines = "FormattedAddressLines"
        let kSubThoroughfare       = "SubThoroughfare"
        let kPostCodeExtension     = "PostCodeExtension"
        let kCity                  = "City"
        let kZIP                   = "ZIP"
        let kCountry               = "Country"
        let kCountryCode           = "CountryCode"
        
        addressDict[kSubAdministrativeArea] = self.subAdministrativeArea
        addressDict[kSubLocality] = self.subLocality as NSString
        addressDict[kState] = self.administrativeAreaCode
        
        addressDict[kStreet] = formattedAddressArray.first! as NSString
        addressDict[kThoroughfare] = self.thoroughfare
        addressDict[kFormattedAddressLines] = formattedAddressArray as AnyObject?
        addressDict[kSubThoroughfare] = self.subThoroughfare
        addressDict[kPostCodeExtension] = "" as AnyObject?
        addressDict[kCity] = self.locality
        
        addressDict[kZIP] = self.postalCode
        addressDict[kCountry] = self.country
        addressDict[kCountryCode] = self.ISOcountryCode
        
        let lat = self.latitude.doubleValue
        let lng = self.longitude.doubleValue
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict as [String : AnyObject]?)
        
        return (placemark as CLPlacemark)
        
        
    }
    
}

class GeocodeGoogleIncoming {
    var serverData : [String: Any] = [:]
    var results : [Results]?
    var status : String?
    var plus_code : Plus_Code?
    init(dict: [String: Any]){
        self.serverData = dict
        
        if let results = dict["results"] as? [[String : Any]] {
            self.results = []
            for object in results {
                let some =  Results(dict: object)
                self.results?.append(some)
                
            }
        }
        if let status = dict["status"] as? String {
            self.status = status
        }
        if let object = dict["plus_code"] as? [String : Any] {
            let some =  Plus_Code(dict: object)
            self.plus_code = some }
    }
    class Results {
        var serverData : [String: Any] = [:]
        var geometry : Geometry?
        var formatted_address : String?
        var place_id : String?
        var address_components : [Address_Components]?
        var types : [Types]?
        var plus_code : Plus_Code?
        init(dict: [String: Any]){
            self.serverData = dict
            
            if let object = dict["geometry"] as? [String : Any] {
                let some =  Geometry(dict: object)
                self.geometry = some }
            if let formatted_address = dict["formatted_address"] as? String {
                self.formatted_address = formatted_address
            }
            if let place_id = dict["place_id"] as? String {
                self.place_id = place_id
            }
            if let address_components = dict["address_components"] as? [[String : Any]] {
                self.address_components = []
                for object in address_components {
                    let some =  Address_Components(dict: object)
                    self.address_components?.append(some)
                    
                }
            }
            if let types = dict["types"] as? [[String]] {
                self.types = []
                
                if types.count > 0 {
                    for object in types.first! {
                        let some =  Types(dict: object)
                        self.types?.append(some)
                        
                    }
                }
            }
            if let object = dict["plus_code"] as? [String : Any] {
                let some =  Plus_Code(dict: object)
                self.plus_code = some }
        }
        class Geometry {
            var serverData : [String: Any] = [:]
            var location : Location?
            var viewport : Viewport?
            var location_type : String?
            init(dict: [String: Any]){
                self.serverData = dict
                
                if let object = dict["location"] as? [String : Any] {
                    let some =  Location(dict: object)
                    self.location = some }
                if let object = dict["viewport"] as? [String : Any] {
                    let some =  Viewport(dict: object)
                    self.viewport = some }
                if let location_type = dict["location_type"] as? String {
                    self.location_type = location_type
                }
            }
            class Location {
                var serverData : [String: Any] = [:]
                var lng : Double?
                var lat : Double?
                init(dict: [String: Any]){
                    self.serverData = dict
                    
                    if let lng = dict["lng"] as? Double {
                        self.lng = lng
                    }
                    if let lat = dict["lat"] as? Double {
                        self.lat = lat
                    }
                }
            }
            class Viewport {
                var serverData : [String: Any] = [:]
                var southwest : Southwest?
                var northeast : Northeast?
                init(dict: [String: Any]){
                    self.serverData = dict
                    
                    if let object = dict["southwest"] as? [String : Any] {
                        let some =  Southwest(dict: object)
                        self.southwest = some }
                    if let object = dict["northeast"] as? [String : Any] {
                        let some =  Northeast(dict: object)
                        self.northeast = some }
                }
                class Southwest {
                    var serverData : [String: Any] = [:]
                    var lng : Double?
                    var lat : Double?
                    init(dict: [String: Any]){
                        self.serverData = dict
                        
                        if let lng = dict["lng"] as? Double {
                            self.lng = lng
                        }
                        if let lat = dict["lat"] as? Double {
                            self.lat = lat
                        }
                    }
                }
                class Northeast {
                    var serverData : [String: Any] = [:]
                    var lng : Double?
                    var lat : Double?
                    init(dict: [String: Any]){
                        self.serverData = dict
                        
                        if let lng = dict["lng"] as? Double {
                            self.lng = lng
                        }
                        if let lat = dict["lat"] as? Double {
                            self.lat = lat
                        }
                    }
                }
            }
        }
        class Address_Components {
            var serverData : [String: Any] = [:]
            var short_name : String?
            var types : [Types]?
            var long_name : String?
            init(dict: [String: Any]){
                self.serverData = dict
                
                if let short_name = dict["short_name"] as? String {
                    self.short_name = short_name
                }
                if let types = dict["types"] as? [[String]] {
                    self.types = []
                    
                    if types.count > 0 {
                        for object in types.first! {
                            let some =  Types(dict: object)
                            self.types?.append(some)
                            
                        }
                    }
                }
                if let long_name = dict["long_name"] as? String {
                    self.long_name = long_name
                }
            }
            class Types {
                var serverData : String = ""
                init(dict: String){
                    self.serverData = dict
                    
                }
            }
        }
        class Types {
            var serverData : String = ""
            init(dict: String){
                self.serverData = dict
                
            }
        }
        class Plus_Code {
            var serverData : [String: Any] = [:]
            var compound_code : String?
            var global_code : String?
            init(dict: [String: Any]){
                self.serverData = dict
                
                if let compound_code = dict["compound_code"] as? String {
                    self.compound_code = compound_code
                }
                if let global_code = dict["global_code"] as? String {
                    self.global_code = global_code
                }
            }
        }
    }
    class Plus_Code {
        var serverData : [String: Any] = [:]
        var compound_code : String?
        var global_code : String?
        init(dict: [String: Any]){
            self.serverData = dict
            
            if let compound_code = dict["compound_code"] as? String {
                self.compound_code = compound_code
            }
            if let global_code = dict["global_code"] as? String {
                self.global_code = global_code
            }
        }
    }
}

/*
 
 func some()  {
 getLocation { (location) in
 LeoLocationManager.sharedInstance.leoReverseGeocodeLocationUsingGoogle(CLLocationCoordinate2D(latitude: 0.7046, longitude: 76.7179), onReverseGeocodingCompletionHandler: { dict in
 print(dict?.status)
 print(LeoLocationManager.StatusGoogleApis.ok.rawValue)
 print(dict?.results?.first?.formatted_address)
 
 })
 
 }
 }
 func getLocation(handler : ((CLLocationCoordinate2D)-> ())? = nil ) {
 LeoLocationManager.sharedInstance.autoUpdate = true
 LeoLocationManager.sharedInstance.keepLastKnownLocation = true
 LeoLocationManager.sharedInstance.leoStartUpdatingLocationWithCompletionHandler { (lat, lng, status, message, error) in
 if status == LeoLocationManager.Status.Allowed.rawValue {
 
 let center = CLLocationCoordinate2D(latitude: lat, longitude: lng)
 
 handler?(center)
 
 LeoLocationManager.sharedInstance.stopUpdatingLocation()
 
 }else {
 
 // LeoLocationManager.sharedInstance.stopUpdatingLocation()
 DispatchQueue.main.async {
 
 //"\(status): Please see your setting screen."
 Alert.showComplex(message: "\(status): Please see your setting screen.", cancelTilte: "OK", otherButtons: "Settings", comletionHandler: { (index) in
 
 if index == 0 {
 if let url = URL(string: "App-Prefs:root=Privacy&path=LOCATION") {
 // If general location settings are disabled then open general location settings
 UIApplication.shared.open(url, options: [:], completionHandler: { (isOpen) in
 print(isOpen)
 })
 }else if let url = URL(string: UIApplication.openSettingsURLString) {
 
 // If general location settings are enabled then open location settings for the app
 UIApplication.shared.open(url, options: [:], completionHandler: { (isOpen) in
 print(isOpen)
 })
 }
 } else {
 
 }
 
 })
 }
 
 
 }
 }
 }
 
 */
