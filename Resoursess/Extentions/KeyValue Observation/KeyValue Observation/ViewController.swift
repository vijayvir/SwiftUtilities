//
//  ViewController.swift
//  KeyValue Observation
//
//  Created by Vijayvir Singh on 01/10/20.
//

import UIKit

class Sample : NSObject{
    @objc dynamic var isLoading = false
}

enum ValidatoinError: Error {
    case error(_ message: String)
    case error1(title : String ,message : String)
    
}
class SampleModel {
    var item : Int = 8
}

class ValidationChecker {
   static func checkValidation(jsonData: [String: Any], callback: @escaping (Result<SampleModel, ValidatoinError>) -> Void){
    callback(.success(SampleModel()))
   // callback(.failure(.error("Simple ErrorMessag e")))
       // callback(.failure(.error1(title: "First Title", message: "Message")))
    }
}

class ViewController: UIViewController {
 
    var sample = Sample()
    
    @IBAction func actionSample(_ sender: UIButton) {
        sample.isLoading = true
    }
    @IBAction func actionNo(_ sender: Any) {
        sample.isLoading = false
    }
    private var observations: [NSKeyValueObservation] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        observations = [ sample.observe(\.isLoading) { [weak self] (value ) in
            print("New Value is ", value )
        }]
        ValidationChecker.checkValidation(jsonData: [:]) { (result) in
            switch result {
            case .success(let value ):
                print(value.item)
            case .failure(let error1):
                switch error1 {
               
                case .error(let sample):
                    print(sample)
                case .error1(title: let title, message: let message):
                    print(title,message)
                }
            }
        }
        
        // Do any additional setup after loading the view.
       
    }


}

