
//
//  LeoLog.swift
//  LeoLogMechanism
//
//  Created by Vijayvir Singh on 01/08/20.
//  Copyright © 2020 Vijayvir Singh. All rights reserved.
//

import Foundation
import MessageUI

///  ~~~
///     LeoLog.tap(on: self)
 ///    LeoLog.write(text: "Some Text \(#function)")
///   ~~~
class LeoLog : NSObject{
    static var shared = LeoLog()
    var vc : UIViewController?
    static func tap(on : UIViewController) {
    let tap = UITapGestureRecognizer(target: LeoLog.shared, action: #selector(LeoLog.shared.handleTap(_:)))
        tap.numberOfTapsRequired = 6
        on.view.addGestureRecognizer(tap)
        LeoLog.shared.vc = on
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let docURL = URL(string: documentsDirectory)!
        let dataPath = docURL.appendingPathComponent("Log")
        print(dataPath.absoluteString)
        
        if !FileManager.default.fileExists(atPath: dataPath.absoluteString) {
            do {
                try FileManager.default.createDirectory(atPath: dataPath.absoluteString, withIntermediateDirectories: true, attributes: nil)
                let logfile = dataPath.appendingPathComponent("Log.txt")
                
                do {
                    if !FileManager.default.fileExists(atPath: logfile.absoluteString) {
                        FileManager.default.createFile(atPath: logfile.absoluteString, contents: nil, attributes: nil)
                    }
                }
                
            } catch {
                print(error.localizedDescription);
            }
            
        }
        
    }
    
    static  func getpath( ) -> URL {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
              let documentsDirectory = paths[0]
              let docURL = URL(string: documentsDirectory)!
              let dataPath = docURL.appendingPathComponent("Log")
            let logfile = dataPath.appendingPathComponent("Log.txt")
            if !FileManager.default.fileExists(atPath: logfile.absoluteString) {
             return logfile
          }
        return logfile
    }
    class func write(text: String , _ file : String = #file , function : String = #function ){
        LeoLog.shared.write(text: "\n\(Date()) \(file) \(function) \(text)")
        
    }
    func write(text : String) {
        fileSize()
        let data = "\(text)\n".data(using: String.Encoding.utf8, allowLossyConversion: false)!
        if FileManager.default.fileExists(atPath: LeoLog.getpath().absoluteString) {
        do{
             let fileHandler =  try FileHandle(forWritingTo: LeoLog.getpath())
                fileHandler.seekToEndOfFile()
                fileHandler.write(data)
                fileHandler.closeFile()
        }
        catch {
                
        }
        }else {
        if !FileManager.default.fileExists(atPath: LeoLog.getpath().absoluteString) {
           FileManager.default.createFile(atPath: LeoLog.getpath().absoluteString, contents: nil, attributes: nil)
    
            }
         
        }
        
    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
       if MFMailComposeViewController.canSendMail() {
          let mail = MFMailComposeViewController()
          mail.setToRecipients(["vijayvir.singh@efuel.app"])
          mail.setSubject("Help Desk")
          mail.setMessageBody("Please not modify the data as it used for loging purpose.", isHTML: true)
          mail.mailComposeDelegate = self
          //add attachment
        if let data = NSData(contentsOfFile: LeoLog.getpath().absoluteString) {
            mail.addAttachmentData(data as Data, mimeType: "text/plain" , fileName: "log.txt")
                 }
        
        LeoLog.shared.vc?.present(mail, animated: true)
          }
       else {
          print("Email cannot be sent")
       }
        
        
        
       }
    func fileSize() {
        let filePath: String = LeoLog.getpath().absoluteString
        do {
            let attr : [FileAttributeKey : Any]? = try  FileManager.default.attributesOfItem(atPath: filePath)
                   if let _attr = attr {
                    if let size = _attr[FileAttributeKey.size] as? UInt64 {
                 
                        if size >= 50000 {
                        if FileManager.default.fileExists(atPath: LeoLog.getpath().absoluteString) {
                            do {
                              
                            try FileManager.default.removeItem(atPath: LeoLog.getpath().absoluteString)
                              }catch {
                                         
                                print("Not have the file ", error.localizedDescription)
                                  }
                                                          
                                                
                        }else {
                            print("\(#function) ,File not exist")
                            }
                          
                        }else {

                        }
                    }
                   }
        }catch {
            
        }
       
    }
}
extension LeoLog : MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
       if let _ = error {
          vc?.dismiss(animated: true, completion: nil)
       }
       switch result {
          case .cancelled:
          print("Cancelled")
          break
          case .sent:
          print("Mail sent successfully")
          break
          case .failed:
          print("Sending mail failed")
          break
          default:
          break
       }
       controller.dismiss(animated: true, completion: nil)
    }
}
