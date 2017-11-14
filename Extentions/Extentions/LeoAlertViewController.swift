import Foundation

import UIKit

class LeoAlertHelper: UIAlertController {

    class func showAlert(_ message: String, completionHandler: (() -> Void)? = nil) {

        let keywindow = UIApplication.shared.keyWindow

        _ = keywindow?.rootViewController

        let alert = UIAlertController(title: "\(appName)", message: message, preferredStyle: UIAlertControllerStyle.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (_: UIAlertAction!) in

            completionHandler?()

        }))

        UIApplication.topViewController()?.present(alert, animated: true, completion: {

        })

    }

    // make sure you have navigation  view controller

    class func alertView(title: String? = "",

                         message: String,

                         preferredStyle: UIAlertControllerStyle? = .alert,

                         cancelTilte: String,

                         otherButtons: String ...,

                         comletionHandler: ((Swift.Int) -> Swift.Void)? = nil) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle!)

        for i in otherButtons {

            //  print( UIApplication.topViewController() ?? i  )

            alert.addAction(UIAlertAction(title: i, style: UIAlertActionStyle.default,

                                          handler: { (action: UIAlertAction!) in

																					comletionHandler?(alert.actions.index(of: action)!)

                                          }
            ))

        }
        if (cancelTilte as String?) != nil {

            alert.addAction(UIAlertAction(title: cancelTilte, style: UIAlertActionStyle.destructive,

                                          handler: { (action: UIAlertAction!) in

																					comletionHandler?(alert.actions.index(of: action)!)

                                          }
            ))
        }

        UIApplication.topViewController()?.present(alert, animated: true, completion: {

        })

    }

}

extension UIApplication {

    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

			if let navigationController = controller as? UINavigationController {

				return topViewController(controller: navigationController.visibleViewController)

			}

			if let tabController = controller as? UITabBarController {

				if let selected = tabController.selectedViewController {

					return topViewController(controller: selected)

				}

			}

			if let presented = controller?.presentedViewController {

				return topViewController(controller: presented)

			}

        // need R and d
        //        if let top = UIApplication.shared.delegate?.window??.rootViewController
        //        {
        //            let nibName = "\(top)".characters.split{$0 == "."}.map(String.init).last!
        //
        //            print(  self,"    d  ",nibName)
        //
        //            return top
        //        }

        return controller
    }
}
