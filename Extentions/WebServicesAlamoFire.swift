//
//  WebServices.swift
//  MedicalApp
//
//  Created by Apple on 12/12/16.
//  Copyright © 2016 vijayvirSingh. All rights reserved.
//

import Foundation

import Alamofire

import UIKit

typealias CompletionBlock = (AnyObject, AnyObject) -> Void

typealias FailureBlock = (AnyObject, AnyObject) -> Void

// ((Swift.Int) -> Swift.Void)? = nil )

// http://fuckingswiftblocksyntax.com

/// https://www.raywenderlich.com/121540/alamofire-tutorial-getting-started

class WebServices {

	///  Almofire Get request

	/// - parameter url:  Path to hit the server

	/// - parameter completionHandler:  Will return tuple of AnyObject and AnyObject

	/// - parameter failureHandler:  Will return tuple of AnyObject and AnyObject

	class func get(url: URL, completionHandler: CompletionBlock? = nil, failureHandler: FailureBlock? = nil) {

		print(" 🛫🛫🛫🛫🛫🛫🛫🛫 get :", url)

		Alamofire.request(url,
		                  method: .get
		)
			.responseJSON { response in
           print("🛬🛬🛬🛬🛬🛬🛬🛬 get: - ", response)
				if let json = response.result.value {



					completionHandler!(json as AnyObject, response.result as AnyObject)

				} else {

					failureHandler?("" as AnyObject, "" as AnyObject)

				}

			}
			.responseString { _ in

				// print(some)

				//	print("responseString Success: \(responseString)")

			}

			.responseData { _ in

		}

	}

	class func post( url: URL, jsonObject: Parameters,
	                 completionHandler: CompletionBlock? = nil,
	                 failureHandler: FailureBlock? = nil) {

		print(" 🛫🛫🛫🛫🛫🛫🛫🛫 post Url:", url, "AlamofireJsonObject: ", jsonObject)

		Alamofire.request(url,
		                  method: .post,
		                  parameters: jsonObject,
		                  encoding: JSONEncoding.default,
		                  headers: ["content-type": "application/json"])
			.responseJSON { response in

				print("post 🛬🛬🛬🛬🛬🛬🛬🛬" , response)

				if let json = response.result.value {

					//print("WebServices json : - ", json)

					completionHandler!(json as AnyObject, response.result as AnyObject)
				} else {

					failureHandler?("" as AnyObject, "" as AnyObject)

				}

			}
			.responseString { _ in

			}

			.responseData { _ in

		}
	}

	class func uploadSingleImage(url: URL, jsonObject: [String : Any],
	                             image: UIImage? = nil,
	                             fileName: String? = NSUUID().uuidString,
	                             completionHandler: CompletionBlock? = nil,
	                             failureHandler: FailureBlock? = nil) {

		let headers: HTTPHeaders = [
			/* "Authorization": "your_access_token",  in case you need authorization header */
			"Content-type": "multipart/form-data"
		]


		Alamofire.upload(multipartFormData: { multipartFormData in

			if let image1 = image {

				if let data = UIImageJPEGRepresentation(image1,  1 ) {

					multipartFormData.append(data,

					                         withName: "signature",

					                         fileName: "\(fileName!)_\(NSUUID().uuidString).jpeg",
						mimeType: "image/jpeg")
				}
			}

			for (key1, value1) in jsonObject {

			let recieveValue = "\(value1)"

			let someData = recieveValue.data(using: .utf8)

			multipartFormData.append(someData! , withName: key1)

			}

		}, to: url ,  headers: headers ) { encodingResult in

			switch encodingResult {

			case .success(let upload, _, _):

				upload.uploadProgress(closure: { _ in

						// Print progress
				})

				upload.responseJSON { response in

					print("JSON*******: \(response)")

					if let json = response.result.value {

						print("JSON: \(json)")

						completionHandler!(json as AnyObject, response.result as AnyObject)

					} else{
						failureHandler?("" as AnyObject, "" as AnyObject)

					}
				}
				upload.responseString(completionHandler: { (string) in
					print("fds" , string)

				})

			case .failure(let encodingError):

				failureHandler?("" as AnyObject, "" as AnyObject)

				print(encodingError)
			}
		}
	}
}

/*

class func upload(jsonObject: AnyObject, files: Array<Any>? = nil, completionHandler: CompletionBlock? = nil, failureHandler: FailureBlock? = nil)
{

print ("Almofire Upload ", jsonObject)

Alamofire.upload(multipartFormData:
{ multipartFormData in

if let filesO = files
{
for i in filesO.enumerated()
{


if let image = UIImage(named: "\(i.element)")
{

let filePath = URL(fileURLWithPath: i.element as! String)

if let data = UIImageJPEGRepresentation(image, 1)
{
multipartFormData.append(data, withName: "signature", fileName: filePath.lastPathComponent, mimeType: "image/jpeg")
}
}



// imgFiles[] give array in Php Side

// imgFiles   will give string in PHP String

}

}

for (key, value) in jsonObject as! [String: String]
{

multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)

}

},
to: baseURL)
{ result
in
switch result
{
case .success(let upload, _, _):

upload.uploadProgress(closure:
{ _ in
// Print progress
})

upload.responseJSON
{ response in

print("JSON: \(response)")

if let json = response.result.value
{
print("JSON: \(json)")

completionHandler!(json as AnyObject, response.result as AnyObject)
}
else
{
failureHandler?("" as AnyObject, "" as AnyObject)

}

}
case .failure(let encodingError):
failureHandler?("" as AnyObject, "" as AnyObject)
print(encodingError)

}

}

}

*/

