//
//  ViewController.swift
//  SiriKitIntentsUIExample
//
//  Created by Domo on 19/11/2019.
//  Copyright © 2019 Domo. All rights reserved.
//

import UIKit
import IntentsUI
// https://medium.com/better-programming/how-to-add-siri-shortcuts-in-your-app-in-swift-7afb61934c4e
//https://medium.com/better-programming/ios-13-custom-intent-with-siri-dialog-909d5d78e9ed

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addSiriButton(to: self.view)
    }

    func addSiriButton(to view: UIView) {
    if #available(iOS 12.0, *) {
        let button = INUIAddVoiceShortcutButton(style: .whiteOutline)
           self.view.translatesAutoresizingMaskIntoConstraints = false
            button.shortcut = INShortcut(intent: intent )
            button.delegate = self
            button.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(button)
            view.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
            view.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        }
      if #available(iOS 12.0, *) {
        let button = INUIAddVoiceShortcutButton(style: .whiteOutline)
            button.shortcut = INShortcut(intent: intent2 )
            button.delegate = self
            
            button.translatesAutoresizingMaskIntoConstraints = false
              button.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(button)
 
        NSLayoutConstraint(item: button,
                                attribute: .leading,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .leading,
                                multiplier: 1,
                                constant: 60).isActive = true

             NSLayoutConstraint(item: button,
                                attribute: .top,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .top,
                                multiplier: 1,
                                constant: 60).isActive = true
        }
    }
    
    func showMessage() {
        let alert = UIAlertController(title: "Done!", message: "This is your first shortcut action!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showMessageTwo() {
        print("Some Thing to here")
        if let sb = UIStoryboard(name: "Main", bundle: nil) as? UIStoryboard{
            if let vc = sb.instantiateViewController(withIdentifier : "SecondViewController") as? SecondViewController{
                self.navigationController?.pushViewController(vc, animated: true )
            }
            
            
        }
    }

}


extension ViewController {
    
    @available(iOS 12.0, *)

    public var intent2 : PushmeCodeIntent{
        let testIntent = PushmeCodeIntent()
        testIntent.suggestedInvocationPhrase = "Test command2"
        return testIntent
    }
    @available(iOS 12.0, *)
    public var intent: DoSomethingIntent {
        let testIntent = DoSomethingIntent()
        testIntent.suggestedInvocationPhrase = "Test command"
        return testIntent
    }
    
//    @available(iOS 12.0, *)
//      public var refuel: PushMeIntent{
//          let testIntent = PushMeIntent()
//          testIntent.suggestedInvocationPhrase = "Test command2"
//          return testIntent
//      }
    
}

extension ViewController: INUIAddVoiceShortcutButtonDelegate {
    @available(iOS 12.0, *)
    func present(_ addVoiceShortcutViewController: INUIAddVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        addVoiceShortcutViewController.delegate = self
        addVoiceShortcutViewController.modalPresentationStyle = .formSheet
        present(addVoiceShortcutViewController, animated: true, completion: nil)
    }
    
    @available(iOS 12.0, *)
    func present(_ editVoiceShortcutViewController: INUIEditVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        editVoiceShortcutViewController.delegate = self
        editVoiceShortcutViewController.modalPresentationStyle = .formSheet
        present(editVoiceShortcutViewController, animated: true, completion: nil)
    }
    
    
}

extension ViewController: INUIAddVoiceShortcutViewControllerDelegate {
    @available(iOS 12.0, *)
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @available(iOS 12.0, *)
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}

extension ViewController: INUIEditVoiceShortcutViewControllerDelegate {
    @available(iOS 12.0, *)
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @available(iOS 12.0, *)
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @available(iOS 12.0, *)
    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
