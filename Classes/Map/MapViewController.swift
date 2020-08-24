

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker

protocol MapProtocol
{
    func setMapDetails(coordinate: CLLocationCoordinate2D,str:String)
}

class MapViewController: UIViewController,GMSMapViewDelegate,CLLocationManagerDelegate,UITextFieldDelegate,GMSAutocompleteViewControllerDelegate
{

    //MARK: - All Outlets
    @IBOutlet var viwMap: GMSMapView!
    
    @IBOutlet var txtAddress: UITextField!
    //MARK: - Local Variables
    var lati:CLLocationDegrees = 0.0
    var longi:CLLocationDegrees = 0.0
    var locationManager = CLLocationManager()
    var marker = GMSMarker()
    var mapDelegate:MapProtocol?
    var isDelegateCalled:Bool = false
    //MARK: - View related methods
    override func viewDidLoad()
    {
        txtAddress.delegate = self
        //self.view.bringSubview(toFront: viwMap)
        super.viewDidLoad()
        marker.isDraggable = true
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        switch CLLocationManager.authorizationStatus()
        {
        case .authorizedWhenInUse, .authorizedAlways:
            if CLLocationManager.locationServicesEnabled()
            {
                viwMap.delegate = self
                let camera = GMSCameraPosition.camera(withLatitude:lati, longitude:longi, zoom: 17.0)
                viwMap.camera = camera
                locationManager.startUpdatingLocation()
                print("Updating location now")
            }
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .restricted, .denied:
            if let settingsURL = NSURL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.openURL(settingsURL as URL)
            }
            //UIApplication.shared.openURL(NSURL(string: "prefs:root=LOCATION_SERVICES")! as URL)
            print("User must enable access in settings")
            break
        }
        // Do any additional setup after loading the view.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        self.present(acController, animated: true, completion: nil)
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace)
    {
        viwMap.camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 15.0)
        print(place)
        print(place.coordinate.latitude)
        print(place.coordinate.longitude)
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress ?? "null")")
        self.txtAddress.text = place.formattedAddress
        print("Place attributions: \(String(describing: place.attributions))")
        
        self.dismiss(animated: true, completion: nil)
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error)
    {
        // TODO: handle the error.
        //        print("Error: \(error.description)")
        self.dismiss(animated: true, completion: nil)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController)
    {
        print("Autocomplete was cancelled.")
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition)
    {
        let location = viwMap.camera.target
        lati = location.latitude
        longi = location.longitude

        //marker.position = CLLocationCoordinate2D(latitude:lati, longitude:longi)
        //marker.map = viwMap
        
        reverseGeocodeCoordinate(location)
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
       
    }
    
    @IBAction func btnAddLocation(_ sender: UIButton)
    {
        let location = viwMap.camera.target
        lati = location.latitude
        longi = location.longitude
        
        let geoCoder = GMSGeocoder()
        
        let myLocation = CLLocation(latitude: lati, longitude: longi)
        
        isDelegateCalled = true
        reverseGeocodeCoordinate(location)
        
    }
    
    @IBAction func btnCurrentLocation(_ sender: UIButton) {
        
        locationManager.startUpdatingLocation()
    }
    
    //MARK: - Location manager delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        print(location!)
        
        lati = (location?.coordinate.latitude)!
        longi = (location?.coordinate.longitude)!
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        
        self.viwMap?.animate(to: camera)
        
        //marker.position = CLLocationCoordinate2D(latitude:lati, longitude:longi)
        //marker.map = viwMap

        self.locationManager.stopUpdatingLocation()
        let loc = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        reverseGeocodeCoordinate(loc)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D)
    {
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate)
        { response, error in
            guard let address = response?.firstResult(),
                let lines = address.lines
                else
            {
//                    GlobalMethod.objGlobalMethod.showSimpleAlert(onView: self, message: "Unable to load please choose again.")
                    return
            }
            print(address)
            
           // self.txtAddress.text = lines.joined(separator: "\n")
            
            var str = ""
            let strThroughFare = address.thoroughfare
            let strSubLocality = address.subLocality
            let strLocality = address.locality
            let strAdmin = address.administrativeArea
            let strCountry = address.country
            let strPostal = address.postalCode
            
            if strThroughFare != nil {
                str = str + String(format: "%@ ",strThroughFare!)
            }
            if strSubLocality != nil {
                str = str + String(format: "%@ ",strSubLocality!)
            }
            if strLocality != nil {
                str = str + String(format: "%@ ",strLocality!)
            }
            if strAdmin != nil {
                str = str + String(format: "%@ ",strAdmin!)
            }
            if strCountry != nil {
                str = str + String(format: "%@ ",strCountry!)
            }
            if strPostal != nil {
                str = str + String(format: "%@",strPostal!)
            }
            print(str)
            self.txtAddress.text = str
            
            if self.isDelegateCalled
            {
              self.mapDelegate?.setMapDetails(coordinate: coordinate, str: str)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

   
}
