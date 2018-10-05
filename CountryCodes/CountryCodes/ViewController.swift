//
//  ViewController.swift
//  CountryCodes
//
//  Created by vijay vir on 8/11/17.
//  Copyright © 2017 vijay vir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var txtCountryCode: CountryPickerTextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	
		txtCountryCode.closureDidSelectCountry = { country in
			
		}
		
        txtCountryCode.closureDidSearch = { countries in
        

            let searchCountryViewController = LeoSearchCountryViewController(countries: countries)
            let navigationViewController = UINavigationController(rootViewController: searchCountryViewController)
            searchCountryViewController.closureDidSelectCountry = { country in
                
                self.txtCountryCode.text = country.name
            }
     
            self.present(navigationViewController, animated: true, completion: nil)
            
            
        }
        
        
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}
/*
import Foundation
import SWXMLHash
struct SoapAddNewPassengerRequestIncomming{
    var addNewPassengerRequestResult: String?
}
class SoapAddNewPassengerRequestOutcomming{
    var soapAddNewPassengerRequestIncomming = SoapAddNewPassengerRequestIncomming()
    var closureAddNewPassengerRequestResponse: ((SoapAddNewPassengerRequestIncomming) -> Void)?
    // 24 parameters to passed while AddNewPassengerRequest Api is called
     func request(userPKUID: String ,
                 pickUpAddress: String,
                 pickUpCity: String,
                 pickUpState: String,
                 pickUpZip: String,
                 pickUpZipPlusFour: String,
                 pickUpLatitude: String,
                 pickUpLongitude: String,
                 pickUpDescription: String,
                 pickUpDate: String,
                 pickUpTime: String,
                 dropOffAddress: String,
                 dropOffCity: String,
                 dropOffState: String,
                 dropOffZip: String,
                 dropOffLatitude: String,
                 dropOffLongitude: String,
                 dropOffZipPlusFour: String,
                 dropOffDescription: String,
                 dropOffDate: String,
                 dropOffTime: String,
                 piecesOfLuggage: String,
                 luggageDescription: String,
                 paymentMethod: String,
                meetUpRadius: String   ){
        
        let headers = [
            "content-type": "text/xml; charset=utf-8",
            "soapaction": EnumSoapActions.addNewPassengerRequest.name,
            "cache-control": "no-cache",
            ]
       //24 parameters
        let postData = NSData(data: "<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><AddNewPassengerRequest xmlns='http://SlideRide.com/'><UserPKUID>\(userPKUID)</UserPKUID><PickUpAddress>\(pickUpAddress)</PickUpAddress><PickUpCity>\(pickUpCity)</PickUpCity><PickUpState>\(pickUpState)</PickUpState><PickUpZip>\(pickUpZip)</PickUpZip><PickUpZipPlusFour>\(pickUpZipPlusFour)</PickUpZipPlusFour><PickUpLatitude>\(pickUpLatitude)</PickUpLatitude><PickUpLongitude>\(pickUpLongitude)</PickUpLongitude><PickUpDescription>\(pickUpDescription)</PickUpDescription><PickUpDate>\(pickUpDate)</PickUpDate><PickUpTime>\(pickUpTime)</PickUpTime><DropOffAddress>\(dropOffAddress)</DropOffAddress><DropOffCity>\(dropOffCity)</DropOffCity><DropOffState>\(dropOffState)</DropOffState><DropOffZip>\(dropOffZip)</DropOffZip><DropOffLatitude>\(dropOffLatitude)</DropOffLatitude><DropOffLongitude>\(dropOffLongitude)</DropOffLongitude><DropOffZipPlusFour>\(dropOffZipPlusFour)</DropOffZipPlusFour><DropOffDescription>\(dropOffDescription)</DropOffDescription><DropOffDate>\(dropOffDate)</DropOffDate><DropOffTime>\(dropOffTime)</DropOffTime><PiecesOfLuggage>\(piecesOfLuggage)</PiecesOfLuggage><LuggageDescription>\(luggageDescription)</LuggageDescription><PaymentMethod>\(paymentMethod)</PaymentMethod><MeetUpRadius>\(meetUpRadius)</MeetUpRadius></AddNewPassengerRequest></soap:Body></soap:Envelope>".data(using: String.Encoding.utf8)!)

        
        let request = NSMutableURLRequest(url: NSURL(string: "http:bcdjkafbakjkb.asmx")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse!)
                let str = String.init(data: data!, encoding: .utf8)
                let xml = SWXMLHash.parse(str!)
                print("👤",xml)
                let userResponse = xml["soap:Envelope"]["soap:Body"]["AddNewPassengerRequestResponse"]["AddNewPassengerRequestResult"].element?.text
                print("🧕🏻 ",userResponse.leoSafe())
              
            }
        })
        
        dataTask.resume()
        
    }
    
    
}
*/
