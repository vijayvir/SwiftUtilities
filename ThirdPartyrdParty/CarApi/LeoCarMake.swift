//
//  LeoCarMake.swift
//
//  Created by Anupriya on 22/01/18.
//  Copyright © 2018 vijay vir. All rights reserved.
//

/* Help https://www.carqueryapi.com/api/0.3/?=?&cmd=getModels&make=abarth
 https://www.carqueryapi.com/api/0.3/?=?&cmd=getMakes
 */
import Foundation

struct LeoCarMake{
	let  urlString : "https://www.carqueryapi.com/api/0.3/?=?&cmd=getMakes"
    var carMakes : [MakeDetail] = []
    struct MakeDetail {
        var makeCountry : String?
        var makeDisplay : String?
        var makeId : String?
        var makeIsCommon : Any?
        init(dictionary : NSDictionary) {
            makeCountry = dictionary["make_country"] as? String
            makeDisplay = dictionary["make_display"] as? String
            makeId = dictionary["make_id"] as? String
            makeIsCommon = dictionary["make_is_common"] as Any
        }
    }
    init(response : AnyObject) {
        if let someLists = response["Makes"] as? [Any]{
            for someList in someLists{
                let tempList = MakeDetail(dictionary: someList as! NSDictionary)
                carMakes.append(tempList)
            }
        }
    }
}

/*[{"model_name":"1000","model_make_id":"abarth"}*/

struct LeoCarModel{
	static func urlString(withMake carMake : LeoCarMake)->String {
		  return "https://www.carqueryapi.com/api/0.3/?=?&cmd=getModels&make=\(carMake.makeId)"
	}

    var carModels : [ModelDetails] = []

	struct ModelDetails{
        var modelName : String?
        var modelMakeId : String?
        init(dictionary : NSDictionary ) {
            modelName = dictionary["model_name"] as? String
            modelMakeId = dictionary["model_make_id"] as? String
            
        }
    }
    
    init(response : AnyObject) {
        
        if let someModels = response["Models"] as? [Any]{
            
            for someModel in someModels{
                
                let tempModel = ModelDetails(dictionary: someModel as! NSDictionary)
                carModels.append(tempModel)
                
            }
            
        }

    }

}







