
import UIKit
class ViewController: UIViewController {

	@IBOutlet var nxSpotEstimatorTimerObject: NxSpotEstimatorTimerObject!

	override func viewDidLoad() {
		super.viewDidLoad()
		nxSpotEstimatorTimerObject.configure()
		nxSpotEstimatorTimerObject.closureDidEstimatorTimeSet  = {
			hrs , mins  , dayLight in
			print( "🚘🚘🚘🚘🚘",hrs , mins , dayLight.name )
		}
	}


	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

}

