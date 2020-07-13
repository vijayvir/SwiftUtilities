//  Created by vijay vir on 8/1/17.
//  Copyright © 2017 vijay vir. All rights reserved.
//
/*
Main purpose  to provide the world codes  in text field through the Pickerview
*/

/* Working of the class

 Ist : make the outlet in class
           @IBOutlet weak var txtCountryCode: CountryPickerTextField!

2nd : use the closure or delegate in view Did load method .

txtCountryCode.closureDidSelectCountry = { country in

print(country)

}

*/

import Foundation

import UIKit

struct World {
    
    struct Country {

        var id: String

        var sortName: String

        var name: String

        var code: String

        init(country: [String: String]) {

            self.id = country["id"] ?? ""

            self.sortName = country["sortName"] ?? ""

            self.name = country["name"] ?? ""

            self.code = country["code"] ?? ""

        }

    }

    var countryList: [Country] = []

    init() {

        for rawCountry in World.countries() {
            if let object = Country(country: rawCountry) as Country? {
                if object.code != "" {
                    countryList.append(object)

                }
                
            }

        }
    }

   private  static func countries() -> [[String: String]] {

        let countryCodes: [[String: String]] =
            [["id": "1", "sortName": "AF", "name": "Afghanistan", "code": ""], ["id": "2", "sortName": "AL", "name": "Albania", "code": ""], ["id": "3", "sortName": "DZ", "name": "Algeria", "code": ""], ["id": "4", "sortName": "AS", "name": "American Samoa", "code": ""], ["id": "5", "sortName": "AD", "name": "Andorra", "code": ""], ["id": "6", "sortName": "AO", "name": "Angola", "code": "+244"], ["id": "7", "sortName": "AI", "name": "Anguilla", "code": "+1 264"], ["id": "8", "sortName": "AQ", "name": "Antarctica", "code": ""], ["id": "9", "sortName": "AG", "name": "Antigua And Barbuda", "code": "+1 268"], ["id": "10", "sortName": "AR", "name": "Argentina", "code": "+54"], ["id": "11", "sortName": "AM", "name": "Armenia", "code": "+374"], ["id": "12", "sortName": "AW", "name": "Aruba", "code": "+297"], ["id": "13", "sortName": "AU", "name": "Australia", "code": "+61"], ["id": "14", "sortName": "AT", "name": "Austria", "code": "+43"], ["id": "15", "sortName": "AZ", "name": "Azerbaijan", "code": "+994"], ["id": "16", "sortName": "BS", "name": "Bahamas The", "code": ""], ["id": "17", "sortName": "BH", "name": "Bahrain", "code": "+973"], ["id": "18", "sortName": "BD", "name": "Bangladesh", "code": "+880"], ["id": "19", "sortName": "BB", "name": "Barbados", "code": "+1 246"], ["id": "20", "sortName": "BY", "name": "Belarus", "code": "+375"], ["id": "21", "sortName": "BE", "name": "Belgium", "code": "+32"], ["id": "22", "sortName": "BZ", "name": "Belize", "code": "+501"], ["id": "23", "sortName": "BJ", "name": "Benin", "code": "+229"], ["id": "24", "sortName": "BM", "name": "Bermuda", "code": "+1 441"], ["id": "25", "sortName": "BT", "name": "Bhutan", "code": "+975"], ["id": "26", "sortName": "BO", "name": "Bolivia", "code": "+591"], ["id": "27", "sortName": "BA", "name": "Bosnia and Herzegovina", "code": "+387"], ["id": "28", "sortName": "BW", "name": "Botswana", "code": "+267"], ["id": "29", "sortName": "BV", "name": "Bouvet Island", "code": ""], ["id": "30", "sortName": "BR", "name": "Brazil", "code": "+55"], ["id": "31", "sortName": "IO", "name": "British Indian Ocean Territory", "code": "+246"], ["id": "32", "sortName": "BN", "name": "Brunei", "code": "+673"], ["id": "33", "sortName": "BG", "name": "Bulgaria", "code": "+359"], ["id": "34", "sortName": "BF", "name": "Burkina Faso", "code": "+226"], ["id": "35", "sortName": "BI", "name": "Burundi", "code": "+257"], ["id": "36", "sortName": "KH", "name": "Cambodia", "code": "+855"], ["id": "37", "sortName": "CM", "name": "Cameroon", "code": "+237"], ["id": "38", "sortName": "CA", "name": "Canada", "code": "+1"], ["id": "39", "sortName": "CV", "name": "Cape Verde", "code": "+238"], ["id": "40", "sortName": "KY", "name": "Cayman Islands", "code": "+ 345"], ["id": "41", "sortName": "CF", "name": "Central African Republic", "code": "+236"], ["id": "42", "sortName": "TD", "name": "Chad", "code": "+235"], ["id": "43", "sortName": "CL", "name": "Chile", "code": "+56"], ["id": "44", "sortName": "CN", "name": "China", "code": "+86"], ["id": "45", "sortName": "CX", "name": "Christmas Island", "code": "+61"], ["id": "46", "sortName": "CC", "name": "Cocos (Keeling) Islands", "code": ""], ["id": "47", "sortName": "CO", "name": "Colombia", "code": "+57"], ["id": "48", "sortName": "KM", "name": "Comoros", "code": "+269"], ["id": "49", "sortName": "CG", "name": "Congo", "code": "+242"], ["id": "50", "sortName": "CD", "name": "Congo The Democratic Republic Of The", "code": ""], ["id": "51", "sortName": "CK", "name": "Cook Islands", "code": "+682"], ["id": "52", "sortName": "CR", "name": "Costa Rica", "code": "+506"], ["id": "53", "sortName": "CI", "name": "Cote D'Ivoire (Ivory Coast)", "code": ""], ["id": "54", "sortName": "HR", "name": "Croatia (Hrvatska)", "code": ""], ["id": "55", "sortName": "CU", "name": "Cuba", "code": "+53"], ["id": "56", "sortName": "CY", "name": "Cyprus", "code": "+357"], ["id": "57", "sortName": "CZ", "name": "Czech Republic", "code": "+420"], ["id": "58", "sortName": "DK", "name": "Denmark", "code": "+45"], ["id": "59", "sortName": "DJ", "name": "Djibouti", "code": "+253"], ["id": "60", "sortName": "DM", "name": "Dominica", "code": "+1 767"], ["id": "61", "sortName": "DO", "name": "Dominican Republic", "code": "+1 809"], ["id": "62", "sortName": "TL", "name": "East Timor", "code": "+670"], ["id": "63", "sortName": "EC", "name": "Ecuador", "code": "+593"], ["id": "64", "sortName": "EG", "name": "Egypt", "code": "+20"], ["id": "65", "sortName": "SV", "name": "El Salvador", "code": "+503"], ["id": "66", "sortName": "GQ", "name": "Equatorial Guinea", "code": "+240"], ["id": "67", "sortName": "ER", "name": "Eritrea", "code": "+291"], ["id": "68", "sortName": "EE", "name": "Estonia", "code": "+372"], ["id": "69", "sortName": "ET", "name": "Ethiopia", "code": "+251"], ["id": "70", "sortName": "XA", "name": "External Territories of Australia", "code": ""], ["id": "71", "sortName": "FK", "name": "Falkland Islands", "code": "+500"], ["id": "72", "sortName": "FO", "name": "Faroe Islands", "code": "+298"], ["id": "73", "sortName": "FJ", "name": "Fiji Islands", "code": ""], ["id": "74", "sortName": "FI", "name": "Finland", "code": "+358"], ["id": "75", "sortName": "FR", "name": "France", "code": "+33"], ["id": "76", "sortName": "GF", "name": "French Guiana", "code": "+594"], ["id": "77", "sortName": "PF", "name": "French Polynesia", "code": "+689"], ["id": "78", "sortName": "TF", "name": "French Southern Territories", "code": ""], ["id": "79", "sortName": "GA", "name": "Gabon", "code": "+241"], ["id": "80", "sortName": "GM", "name": "Gambia The", "code": ""], ["id": "81", "sortName": "GE", "name": "Georgia", "code": "+995"], ["id": "82", "sortName": "DE", "name": "Germany", "code": "+49"], ["id": "83", "sortName": "GH", "name": "Ghana", "code": "+233"], ["id": "84", "sortName": "GI", "name": "Gibraltar", "code": "+350"], ["id": "85", "sortName": "GR", "name": "Greece", "code": "+30"], ["id": "86", "sortName": "GL", "name": "Greenland", "code": "+299"], ["id": "87", "sortName": "GD", "name": "Grenada", "code": "+1 473"], ["id": "88", "sortName": "GP", "name": "Guadeloupe", "code": "+590"], ["id": "89", "sortName": "GU", "name": "Guam", "code": "+1 671"], ["id": "90", "sortName": "GT", "name": "Guatemala", "code": "+502"], ["id": "92", "sortName": "GN", "name": "Guinea", "code": "+224"], ["id": "93", "sortName": "GW", "name": "Guinea-Bissau", "code": "+245"], ["id": "94", "sortName": "GY", "name": "Guyana", "code": "+595"], ["id": "95", "sortName": "HT", "name": "Haiti", "code": "+509"], ["id": "96", "sortName": "HM", "name": "Heard and McDonald Islands", "code": ""], ["id": "97", "sortName": "HN", "name": "Honduras", "code": "+504"], ["id": "98", "sortName": "HK", "name": "Hong Kong S.A.R.", "code": ""], ["id": "99", "sortName": "HU", "name": "Hungary", "code": "+36"], ["id": "100", "sortName": "IS", "name": "Iceland", "code": "+354"], ["id": "101", "sortName": "IN", "name": "India", "code": "+91"], ["id": "102", "sortName": "ID", "name": "Indonesia", "code": "+62"], ["id": "103", "sortName": "IR", "name": "Iran", "code": "+98"], ["id": "104", "sortName": "IQ", "name": "Iraq", "code": "+964"], ["id": "105", "sortName": "IE", "name": "Ireland", "code": "+353"], ["id": "106", "sortName": "IL", "name": "Israel", "code": "+972"], ["id": "107", "sortName": "IT", "name": "Italy", "code": "+39"], ["id": "108", "sortName": "JM", "name": "Jamaica", "code": "+1 876"], ["id": "109", "sortName": "JP", "name": "Japan", "code": "+81"], ["id": "110", "sortName": "JE", "name": "Jersey", "code": "+44"], ["id": "111", "sortName": "JO", "name": "Jordan", "code": "+962"], ["id": "112", "sortName": "KZ", "name": "Kazakhstan", "code": "+7 7"], ["id": "113", "sortName": "KE", "name": "Kenya", "code": "+254"], ["id": "114", "sortName": "KI", "name": "Kiribati", "code": "+686"], ["id": "115", "sortName": "KP", "name": "Korea North", "code": ""], ["id": "116", "sortName": "KR", "name": "Korea South", "code": ""], ["id": "117", "sortName": "KW", "name": "Kuwait", "code": "+965"], ["id": "118", "sortName": "KG", "name": "Kyrgyzstan", "code": "+996"], ["id": "119", "sortName": "LA", "name": "Laos", "code": "+856"], ["id": "120", "sortName": "LV", "name": "Latvia", "code": "+371"], ["id": "121", "sortName": "LB", "name": "Lebanon", "code": "+961"], ["id": "122", "sortName": "LS", "name": "Lesotho", "code": "+266"], ["id": "123", "sortName": "LR", "name": "Liberia", "code": "+231"], ["id": "124", "sortName": "LY", "name": "Libya", "code": "+218"], ["id": "125", "sortName": "LI", "name": "Liechtenstein", "code": "+423"], ["id": "126", "sortName": "LT", "name": "Lithuania", "code": "+370"], ["id": "127", "sortName": "LU", "name": "Luxembourg", "code": "+352"], ["id": "128", "sortName": "MO", "name": "Macau S.A.R.", "code": ""], ["id": "129", "sortName": "MK", "name": "Macedonia", "code": "+389"], ["id": "130", "sortName": "MG", "name": "Madagascar", "code": "+261"], ["id": "131", "sortName": "MW", "name": "Malawi", "code": "+265"], ["id": "132", "sortName": "MY", "name": "Malaysia", "code": "+60"], ["id": "133", "sortName": "MV", "name": "Maldives", "code": "+960"], ["id": "134", "sortName": "ML", "name": "Mali", "code": "+223"], ["id": "135", "sortName": "MT", "name": "Malta", "code": "+356"], ["id": "136", "sortName": "XM", "name": "Man (Isle of)", "code": "+44"], ["id": "137", "sortName": "MH", "name": "Marshall Islands", "code": "+692"], ["id": "138", "sortName": "MQ", "name": "Martinique", "code": "+596"], ["id": "139", "sortName": "MR", "name": "Mauritania", "code": "+222"], ["id": "140", "sortName": "MU", "name": "Mauritius", "code": "+230"], ["id": "141", "sortName": "YT", "name": "Mayotte", "code": "+262"], ["id": "142", "sortName": "MX", "name": "Mexico", "code": "+52"], ["id": "143", "sortName": "FM", "name": "Micronesia", "code": "+691"], ["id": "144", "sortName": "MD", "name": "Moldova", "code": "+373"], ["id": "145", "sortName": "MC", "name": "Monaco", "code": "+377"], ["id": "146", "sortName": "MN", "name": "Mongolia", "code": "+976"], ["id": "147", "sortName": "MS", "name": "Montserrat", "code": "+1664"], ["id": "148", "sortName": "MA", "name": "Morocco", "code": "+212"], ["id": "149", "sortName": "MZ", "name": "Mozambique", "code": ""], ["id": "150", "sortName": "MM", "name": "Myanmar", "code": "+95"], ["id": "151", "sortName": "NA", "name": "Namibia", "code": "+264"], ["id": "152", "sortName": "NR", "name": "Nauru", "code": "+674"], ["id": "153", "sortName": "NP", "name": "Nepal", "code": "+977"], ["id": "154", "sortName": "ANT", "name": "Netherlands Antilles", "code": "+599"], ["id": "155", "sortName": "NL", "name": "Netherlands The", "code": ""], ["id": "156", "sortName": "NC", "name": "New Caledonia", "code": "+687"], ["id": "157", "sortName": "NZ", "name": "New Zealand", "code": "+64"], ["id": "158", "sortName": "NI", "name": "Nicaragua", "code": "+505"], ["id": "159", "sortName": "NE", "name": "Niger", "code": "+227"], ["id": "160", "sortName": "NG", "name": "Nigeria", "code": "+234"], ["id": "161", "sortName": "NU", "name": "Niue", "code": "+683"], ["id": "162", "sortName": "NF", "name": "Norfolk Island", "code": "+672"], ["id": "163", "sortName": "MP", "name": "Northern Mariana Islands", "code": "+1 670"], ["id": "164", "sortName": "NO", "name": "Norway", "code": "+47"], ["id": "165", "sortName": "OM", "name": "Oman", "code": "+968"], ["id": "166", "sortName": "PK", "name": "Pakistan", "code": "+92"], ["id": "167", "sortName": "PW", "name": "Palau", "code": "+680"], ["id": "168", "sortName": "PS", "name": "Palestinian Territory Occupied", "code": ""], ["id": "169", "sortName": "PA", "name": "Panama", "code": "+507"], ["id": "170", "sortName": "PG", "name": "Papua new Guinea", "code": "+675"], ["id": "171", "sortName": "PY", "name": "Paraguay", "code": "+595"], ["id": "172", "sortName": "PE", "name": "Peru", "code": "+51"], ["id": "173", "sortName": "PH", "name": "Philippines", "code": "+63"], ["id": "174", "sortName": "PN", "name": "Pitcairn Island", "code": ""], ["id": "175", "sortName": "PL", "name": "Poland", "code": "+48"], ["id": "176", "sortName": "PT", "name": "Portugal", "code": "+351"], ["id": "177", "sortName": "PR", "name": "Puerto Rico", "code": "+1 787"], ["id": "178", "sortName": "QA", "name": "Qatar", "code": "+974"], ["id": "179", "sortName": "RE", "name": "Reunion", "code": "+262"], ["id": "180", "sortName": "RO", "name": "Romania", "code": "+40"], ["id": "181", "sortName": "RU", "name": "Russia", "code": "+7"], ["id": "182", "sortName": "RW", "name": "Rwanda", "code": "+250"], ["id": "183", "sortName": "SH", "name": "Saint Helena", "code": ""], ["id": "184", "sortName": "KN", "name": "Saint Kitts And Nevis", "code": ""], ["id": "185", "sortName": "LC", "name": "Saint Lucia", "code": ""], ["id": "186", "sortName": "PM", "name": "Saint Pierre and Miquelon", "code": ""], ["id": "187", "sortName": "VC", "name": "Saint Vincent And The Grenadines", "code": ""], ["id": "188", "sortName": "WS", "name": "Samoa", "code": "+685"], ["id": "189", "sortName": "SM", "name": "San Marino", "code": "+378"], ["id": "190", "sortName": "ST", "name": "Sao Tome and Principe", "code": ""], ["id": "191", "sortName": "SA", "name": "Saudi Arabia", "code": "+966"], ["id": "192", "sortName": "SN", "name": "Senegal", "code": "+221"], ["id": "193", "sortName": "RS", "name": "Serbia", "code": "+381"], ["id": "194", "sortName": "SC", "name": "Seychelles", "code": "+248"], ["id": "195", "sortName": "SL", "name": "Sierra Leone", "code": "+232"], ["id": "196", "sortName": "SG", "name": "Singapore", "code": "+65"], ["id": "197", "sortName": "SK", "name": "Slovakia", "code": "+421"], ["id": "198", "sortName": "SI", "name": "Slovenia", "code": "+386"], ["id": "200", "sortName": "SB", "name": "Solomon Islands", "code": "+677"], ["id": "201", "sortName": "SO", "name": "Somalia", "code": "+252"], ["id": "202", "sortName": "ZA", "name": "South Africa", "code": "+27"], ["id": "203", "sortName": "GS", "name": "South Georgia", "code": ""], ["id": "204", "sortName": "SS", "name": "South Sudan", "code": ""], ["id": "205", "sortName": "ES", "name": "Spain", "code": "+34"], ["id": "206", "sortName": "LK", "name": "Sri Lanka", "code": "+94"], ["id": "207", "sortName": "SD", "name": "Sudan", "code": "+249"], ["id": "208", "sortName": "SR", "name": "Suriname", "code": "+597"], ["id": "209", "sortName": "SJ", "name": "Svalbard And Jan Mayen Islands", "code": ""], ["id": "210", "sortName": "SZ", "name": "Swaziland", "code": "+268"], ["id": "211", "sortName": "SE", "name": "Sweden", "code": "+46"], ["id": "212", "sortName": "CH", "name": "Switzerland", "code": "+41"], ["id": "213", "sortName": "SY", "name": "Syria", "code": "+963"], ["id": "214", "sortName": "TW", "name": "Taiwan", "code": "+886"], ["id": "215", "sortName": "TJ", "name": "Tajikistan", "code": "+992"], ["id": "216", "sortName": "TZ", "name": "Tanzania", "code": "+255"], ["id": "217", "sortName": "TH", "name": "Thailand", "code": "+66"], ["id": "218", "sortName": "TG", "name": "Togo", "code": "+228"], ["id": "219", "sortName": "TK", "name": "Tokelau", "code": "+690"], ["id": "220", "sortName": "TO", "name": "Tonga", "code": "+676"], ["id": "221", "sortName": "TT", "name": "Trinidad And Tobago", "code": "+1 868"], ["id": "222", "sortName": "TN", "name": "Tunisia", "code": "+216"], ["id": "223", "sortName": "TR", "name": "Turkey", "code": "+90"], ["id": "224", "sortName": "TM", "name": "Turkmenistan", "code": "+993"], ["id": "225", "sortName": "TC", "name": "Turks And Caicos Islands", "code": "+1 649"], ["id": "226", "sortName": "TV", "name": "Tuvalu", "code": "+688"], ["id": "227", "sortName": "UG", "name": "Uganda", "code": "+256"], ["id": "228", "sortName": "UA", "name": "Ukraine", "code": "+380"], ["id": "229", "sortName": "AE", "name": "United Arab Emirates", "code": "+971"], ["id": "230", "sortName": "GB", "name": "United Kingdom", "code": "+44"], ["id": "231", "sortName": "US", "name": "United States", "code": "+1"], ["id": "232", "sortName": "UM", "name": "United States Minor Outlying Islands", "code": ""], ["id": "233", "sortName": "UY", "name": "Uruguay", "code": "+598"], ["id": "234", "sortName": "UZ", "name": "Uzbekistan", "code": "+998"], ["id": "235", "sortName": "VU", "name": "Vanuatu", "code": "+678"], ["id": "236", "sortName": "VA", "name": "Vatican City State (Holy See)", "code": ""], ["id": "237", "sortName": "VE", "name": "Venezuela", "code": "+58"], ["id": "238", "sortName": "VN", "name": "Vietnam", "code": "+84"], ["id": "239", "sortName": "VG", "name": "Virgin Islands (British)", "code": ""], ["id": "240", "sortName": "VI", "name": "Virgin Islands (US)", "code": ""], ["id": "241", "sortName": "WF", "name": "Wallis And Futuna Islands", "code": ""], ["id": "242", "sortName": "EH", "name": "Western Sahara", "code": ""], ["id": "243", "sortName": "YE", "name": "Yemen", "code": "+967"], ["id": "244", "sortName": "YU", "name": "Yugoslavia", "code": "+38"], ["id": "245", "sortName": "ZM", "name": "Zambia", "code": "+260"], ["id": "246", "sortName": "ZW", "name": "Zimbabwe", "code": "+263"]]

        return countryCodes
    }

}

class CountryPickerTextField: UITextField, UIPickerViewDelegate, UIPickerViewDataSource {

    var pickerView: UIPickerView = UIPickerView()

    var world: World = World()

    
    // Use this class to have single image.
    
    public  var closureDidSelectCountry: ((_ image: World.Country ) -> Void)?
    
    public  var closureDidSearch: ((_ lists: [ World.Country ] ) -> Void)?
    
    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        addInputAccessoryView()

        self.inputView = pickerView

        //self.textColor = AppColor.theme.color

        pickerView.dataSource = self

        pickerView.delegate = self

        pickerView.selectRow(81, inComponent: 0, animated: true)

        if let index = pickerView.selectedRow(inComponent: 0) as Int? {
                    
            let country: World.Country = world.countryList[index]

            self.text = "\(country.code)"
        }

    }

    func addInputAccessoryView() {
        let toolbar = UIToolbar()

        toolbar.sizeToFit()

        let searchButton = UIBarButtonItem(title: "Search", style: .done, target: self, action: #selector(searchButtonTapped(sender:)))

        
        let donebutton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(menuButtonTapped(sender:)))

        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        var arraybutton: [UIBarButtonItem] = []

     //   arraybutton.append(donebutton)

        arraybutton.append(searchButton)
        
        arraybutton.append(space)

        arraybutton.append(donebutton)

        toolbar.setItems(arraybutton, animated: true)

        self.inputAccessoryView = toolbar
    }

    override func awakeFromNib() {

        super.awakeFromNib()

        print("\(String(describing: self.inputAccessoryView))")
    }
    deinit {

    }


    @objc func searchButtonTapped(sender _: UIBarButtonItem) {
    
        closureDidSearch?(world.countryList)
    }
    
    @objc func menuButtonTapped(sender _: UIBarButtonItem) {

        if let index = pickerView.selectedRow(inComponent: 0) as Int? {
            let country: World.Country = world.countryList[index]

            self.text = "\(country.code)"
                    
                     closureDidSelectCountry?(country)
        }

        _ = resignFirstResponder()

    }

    func pickerTextFieldEditingDidEnd(_: UITextField) {

    }

    // MARK: PickerViewDelegate

    public func numberOfComponents(in _: UIPickerView) -> Int {
        return 1
    }
    public func pickerView(_: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
        return world.countryList.count
    }

    func flag(_ country: String) -> String {
        let base = 127397

        var usv = String.UnicodeScalarView()

        for i in country.utf16 {
            usv.append(UnicodeScalar(base + Int(i))!)
        }
        return String(usv)
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let country: World.Country = world.countryList[row]

        return " \(flag(country.sortName)) \(country.name)  \(country.code) \(row)"

    }

    func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent _: Int) {
            
        let country: World.Country = world.countryList[row]

        self.text = "\(country.code)"

        closureDidSelectCountry?(country)
            
    }

    class func phoneNumberComponets(phoneNumber: String, maxLenght: Int? = 10) -> (String, String) {

        let phoneNumberStg = phoneNumber as NSString

        let phone: String = phoneNumberStg.substring(from: max(phoneNumberStg.length - maxLenght!, 0))

        let ext = phoneNumberStg.replacingOccurrences(of: phone, with: "")

        return (ext, phone)

    }

}
