//
//  WebServices.swift
//  MedicalApp
//
//  Created by Apple on 12/12/16.
//  Copyright © 2016 vijayvirSingh. All rights reserved.
//
import Foundation
import Alamofire
typealias CompletionBlock = ([String : Any]) -> Void
typealias FailureBlock = ([String : Any]) -> Void
// ((Swift.Int) -> Swift.Void)? = nil )
// http://fuckingswiftblocksyntax.com
/// https://www.raywenderlich.com/121540/alamofire-tutorial-getting-started
func isConnectedToInternet() ->Bool {
    return NetworkReachabilityManager()!.isReachable
}
class WebServices {
    
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
    
    class func post( url : Api,jsonObject: [String : Any]  , method : HTTPMethod? = .post , completionHandler: CompletionBlock? = nil, failureHandler: FailureBlock? = nil) {
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
            
            let data = UIImageJPEGRepresentation(profiePic, 1)!
            
            multipartFormData.append(data, withName: "image", fileName: "\(NSUUID().uuidString).jpeg", mimeType: "image/jpeg")
            
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
    
    
    
    class func uploadMultile( url : Api,jsonObject: [String : Any] , files :[String] , completionHandler: CompletionBlock? = nil, failureHandler: FailureBlock? = nil) {
        let urlString = url.baseURl()
        
        print(urlString)
        
        let parameters: Parameters = jsonObject
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60 * 60
        manager.upload(multipartFormData: { multipartFormData in
            
            
            
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
            
            for file in files {
                let directoryName = makeRefferenceCodeDirectory()
                
                var url = URL(fileURLWithPath: directoryName)
                
                let filename = file
                
                url = url.appendingPathComponent(filename)
                
                if FileManager.default.fileExists(atPath: url.path) {
                    
                    if url.pathExtension == "jpg" {
                        
                        if let profiePic =  UIImage(contentsOfFile: url.path) {
                            
                            let data = UIImageJPEGRepresentation(profiePic, 0.5)!
                            
                            multipartFormData.append(data, withName: "files", fileName: file, mimeType: "image/jpeg")
                            
                        
                            
                        }
                        
                    }else {
                   //     multipartFormData.append( url.path, withName: "File1", fileName: file, mimeType: "video/mp4")
                        // here you can upload any type of video
                        //multipartFormData.append(self.selectedVideoURL!, withName: "File1")
                        
                        
                        multipartFormData.append(url, withName: "files", fileName: file, mimeType: "video/mp4")
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






