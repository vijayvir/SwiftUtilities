//
//  WebServices.swift
//  MedicalApp
//
//  Created by Apple on 12/12/16.
//  Copyright © 2016 vijayvirSingh. All rights reserved.
//
/*
 Basic Auth with Parameters
 Auth Token with Parameters
 Simple Post or Get
 Single Upload
 Multiple Upload
 */
import Foundation
import Alamofire
typealias CompletionBlock = ([String : Any]) -> Void
typealias FailureBlock = ([String : Any]) -> Void
typealias ProgressBlock = (Double) -> Void

// ((Swift.Int) -> Swift.Void)? = nil )
// http://fuckingswiftblocksyntax.com
/// https://www.raywenderlich.com/121540/alamofire-tutorial-getting-started
func isConnectedToInternet() ->Bool {
    return NetworkReachabilityManager()!.isReachable
}

extension String: ParameterEncoding {
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }
    
}
class WebServices {
    
    enum ContentType : String {
        case applicationJson = "application/json"
        case textPlain = "text/plain"
    }
    
    static var manager = Alamofire.SessionManager.default
    class func postAuth( url : Api,
                         parameters  : [String : Any]  ,
                         method : HTTPMethod? = .post ,
                         contentType: ContentType? = .applicationJson,
                         authorization : (user: String, password: String)? = nil,
                         authorizationToken : String?  = nil,
                         completionHandler: CompletionBlock? = nil,
                         failureHandler: FailureBlock? = nil){
        var headers : HTTPHeaders = [
            "Content-Type": contentType!.rawValue,
            "cache-control": "no-cache",
            ]
        
        if authorization != nil {
            if let authorization1 = authorization {
                if let authorizationHeader = Request.authorizationHeader(user: authorization1.user, password: authorization1.password) {
                    headers[authorizationHeader.key] = authorizationHeader.value
                }
            }
        }
        if authorizationToken  != nil {
            headers["Authorization"] = "Bearer \(authorizationToken!)"
        }
        let urlString = url.baseURl()
        print("url->",urlString)
        var somString = ""
        
        let dictionary = parameters
        
        if let theJSONData = try?  JSONSerialization.data(
            withJSONObject: dictionary,
            options: .prettyPrinted
            ), let theJSONText = String(data: theJSONData,
                                        encoding: String.Encoding.ascii) {
            
            somString = theJSONText
        }
        
        
        let configuration = URLSessionConfiguration.background(withIdentifier: "com.fittingroom.newtimezone.Fitzz")
        configuration.timeoutIntervalForRequest = 60 * 60 * 00
        WebServices.manager = Alamofire.SessionManager(configuration: configuration)
        
        var encodeSting : ParameterEncoding = somString
        
        if method == .get {
            encodeSting = URLEncoding.default
        }
        
        Alamofire.request(urlString, method: method!,parameters: parameters,encoding:encodeSting ,  headers:headers  )
            .responseJSON {
                response in
                switch (response.result) {
                case .success(let value):
                    
                    completionHandler!(value as! [String : Any] )
                case .failure(let error):
                    print(error)
                    failureHandler?([:] )
                }
            }
            .responseString { _ in
            }
            .responseData { response in
                if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)")
                }
        }
        
        
    }
    
    class func downloadFile(url :String , completionHandler: CompletionBlock? = nil) {
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
        Alamofire.download(
            url,
            method: .get,
            parameters: [:],
            encoding: JSONEncoding.default,
            headers: nil,
            to: destination).downloadProgress(closure: { (progress) in
                
                //progress closure
            }).response(completionHandler: { (DefaultDownloadResponse) in
                
                print(DefaultDownloadResponse)
                completionHandler?([ : ])
                //here you able to access the DefaultDownloadResponse
                //result closure
            })
        
        
    }
    
    
    
    
    
    
    class func post( url : Api,jsonObject: [String : Any]  ,
                     method : HTTPMethod? = .post ,
                     completionHandler: CompletionBlock? = nil,
                     failureHandler: FailureBlock? = nil ) {
        let urlString = url.baseURl()
        
        print(urlString)
        let parameters: Parameters = jsonObject
        Alamofire.request(urlString, method: method!, parameters: parameters)
            .responseJSON {
                response in
                switch (response.result) {
                case .success(let value):
                    completionHandler!(value as! [String : Any] )
                case .failure(let error):
                    print(error)
                    failureHandler?([:] )
                }
            }
            .responseString { _ in
            }
            .responseData { response in
                if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)")
                }
        }
    }
    
    class func uploadSingle( url : Api,jsonObject: [String : Any] , profiePic:UIImage , completionHandler: CompletionBlock? = nil, failureHandler: FailureBlock? = nil) {
        
        let urlString = url.baseURl()
        print(urlString)
        let parameters: Parameters = jsonObject
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            let data = profiePic.jpegData(compressionQuality: 1)
            
            
            //  UIImageJPEGRepresentation(profiePic, 1)!
            
            multipartFormData.append(data!, withName: "image", fileName: "\(NSUUID().uuidString).jpeg", mimeType: "image/jpeg")
            
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
            
        },
                         to: urlString) { result  in
                            switch result {
                            case .success(let upload, _, _):
                                
                                upload.uploadProgress(closure: { _ in
                                    // Print progress
                                    
                                })
                                upload.responseJSON { response in
                                    switch (response.result) {
                                    case .success(let value):
                                        completionHandler!(value as! [String : Any] )
                                    case .failure(let error):
                                        print(error)
                                        failureHandler?([:] )
                                    }
                                    
                                }
                                
                            case .failure(let encodingError):
                                print(encodingError)
                            }
                            
        }
    }
    class func uploadMultile( url : Api,jsonObject: [String : Any] , files :[String] , completionHandler: CompletionBlock? = nil, failureHandler: FailureBlock? = nil , progessHandler : ProgressBlock? = nil) {
        let urlString = url.baseURl()
        let parameters: Parameters = jsonObject
        let configuration = URLSessionConfiguration.background(withIdentifier: "com.fittingroom.newtimezone.Fitzz")
        configuration.timeoutIntervalForRequest = 60 * 60 * 00
        WebServices.manager = Alamofire.SessionManager(configuration: configuration)
        WebServices.manager.upload(multipartFormData: { multipartFormData in
            
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
            
            for (index , file) in files.enumerated() {
                
                let directoryName = ""
                
                var url = URL(fileURLWithPath: directoryName)
                
                let filename = file
                
                url = url.appendingPathComponent(filename)
                
                if FileManager.default.fileExists(atPath: url.path) {
                    
                    if url.pathExtension == "jpg" {
                        
                        if let profiePic =  UIImage(contentsOfFile: url.path) {
                            let data = profiePic.jpegData(compressionQuality: 0.5)
                            
                            
                            multipartFormData.append(data!, withName: "images", fileName: file, mimeType: "image/jpeg")
                            
                            
                            
                        }
                        
                    }else {
                        //     multipartFormData.append( url.path, withName: "File1", fileName: file, mimeType: "video/mp4")
                        // here you can upload any type of video
                        //multipartFormData.append(self.selectedVideoURL!, withName: "File1")
                        
                        
                        multipartFormData.append(url, withName: "images", fileName: file, mimeType: "video/mp4")
                        // here you can upload any type of video
                        //multipartFormData.append(self.selectedVideoURL!, withName: "File1")
                        //  multipartFormData.append(("VIDEO".data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "Type")
                        
                        
                        // multipartFormData.append(("VIDEO".data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "Type")
                        
                    }
                    
                    
                }
                
            }
            
            
        },
                                   to: urlString) { result  in
                                    switch result {
                                    case .success(let upload, _, _):
                                        
                                        upload.uploadProgress(closure: { value in
                                            
                                            
                                            progessHandler?(value.fractionCompleted)
                                            print("uploadProgress---" , value)
                                        })
                                        upload.responseJSON { response in
                                            switch (response.result) {
                                            case .success(let value):
                                                completionHandler!(value as! [String : Any] )
                                            case .failure(let error):
                                                print(error)
                                                failureHandler?([:] )
                                            }
                                            
                                        }
                                        
                                    case .failure(let encodingError):
                                        print(encodingError)
                                        failureHandler?([:] )
                                    }
                                    
        }
        
        
    }
    
    
    
}






