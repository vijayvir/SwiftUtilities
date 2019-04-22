import Foundation
import UIKit
enum THButtonsType : Int  {
    case back = 1
    case front = 2
    case calender = 3
    case clock = 4
    case password = 5
    case edit = 6
    case user = 7
    case camera = 8
    case cross = 9
    case check = 10
    case phone = 11
    case setting = 12
    case down = 13
    case up = 14
    case email = 15
    case gallary = 16
    case location = 17
    case logout = 18
    case menu = 19
    case play = 20
    case radioOn = 21
    case radioOff = 22
    case plus = 23
    case minus = 24
}
@IBDesignable
class THButton: UIButton {
    @IBInspectable  var type: Int = THButtonsType.back.rawValue
    @IBInspectable  var theme: UIColor = .red
    
    override func draw(_ rect: CGRect) {
        if type == THButtonsType.back.rawValue {
            self.setImage(  THButtons.imageOfBacK(theme: theme), for: .normal)
        }else if type == THButtonsType.front.rawValue {
            self.setImage(  THButtons.imageOfFront(theme: theme), for: .normal)
        }else if type == THButtonsType.calender.rawValue {
            self.setImage(  THButtons.imageOfCalendarCanvas(theme: theme), for: .normal)
        }else if type == THButtonsType.phone.rawValue {
            self.setImage(  THButtons.imageOfPhone(theme: theme), for: .normal)
        }else if type == THButtonsType.edit.rawValue {
            self.setImage(  THButtons.imageOfPencileditbuttonCanvas(theme: theme), for: .normal)
        }else if type == THButtonsType.setting.rawValue {
            self.setImage(  THButtons.imageOfSettingsCanvas(theme: theme), for: .normal)
        }else if type == THButtonsType.down.rawValue {
            self.setImage(  THButtons.imageOfDropCanvas(theme: theme), for: .normal)
        }else if type == THButtonsType.up.rawValue {
            self.setImage(  THButtons.imageOfUpCanvas(theme: theme), for: .normal)
        }else if type == THButtonsType.check.rawValue {
            self.setImage(  THButtons.imageOfCheckedCanvas2(theme: theme), for: .normal)
        }else if type == THButtonsType.cross.rawValue {
            self.setImage(  THButtons.imageOfCross(theme: theme), for: .normal)
        }else if type == THButtonsType.user.rawValue {
            self.setImage(  THButtons.imageOfUserCanvas(theme: theme), for: .normal)
        }else if type == THButtonsType.email.rawValue {
            self.setImage(  THButtons.imageOfEmailCanvase(theme: theme), for: .normal)
        }else if type == THButtonsType.camera.rawValue {
            self.setImage(  THButtons.imageOfCameraCanvas(theme: theme), for: .normal)
        }else if type == THButtonsType.gallary.rawValue {
            self.setImage(  THButtons.imageOfPictureCanvas(theme: theme), for: .normal)
        }else if type == THButtonsType.location.rawValue {
            self.setImage(  THButtons.imageOfLocationCanvas(theme: theme), for: .normal)
        }else if type == THButtonsType.clock.rawValue {
            self.setImage(  THButtons.imageOfClockCanavas(theme: theme), for: .normal)
        }else if type == THButtonsType.logout.rawValue {
            self.setImage(  THButtons.imageOfLogoutCanvas(theme: theme), for: .normal)
        }else if type == THButtonsType.menu.rawValue {
            self.setImage(  THButtons.imageOfMenuCanvas(theme: theme), for: .normal)
        }else if type == THButtonsType.play.rawValue {
            self.setImage(  THButtons.imageOfPlaybuttonCanvas(theme: theme), for: .normal)
        }else if type == THButtonsType.radioOn.rawValue {
            self.setImage(  THButtons.imageOfRadioonbuttonCanvas(theme: theme), for: .normal)
        }else if type == THButtonsType.radioOff.rawValue {
            self.setImage(  THButtons.imageOfRadiooffbuttonCanvas2(theme: theme), for: .normal)
        }else if type == THButtonsType.plus.rawValue {
            self.setImage(  THButtons.imageOfPlusCanvas(theme: theme), for: .normal)
        }else if type == THButtonsType.minus.rawValue {
            self.setImage(  THButtons.imageOfMinusCanvas(theme: theme), for: .normal)
        } else if type == THButtonsType.password.rawValue {
            self.setImage(  THButtons.imageOfPasswordCanvas(theme: theme), for: .normal)
        }
    }
}

