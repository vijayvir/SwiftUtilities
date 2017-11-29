#  UIDatePickerTextfield

## Why this class is made ?
 sometimes we need a date from date picker and to show this date in ui and pass to server's database.
In normal approach we make a textfield and the picker view and bind picker view data totext field  . This process is time consumming and for every screens , we have to copy paste the code . But in `UIDatePickerTextfield` all things are bind in one class of textfiled and developer get the desire output in every state  through reactor approach .

 ## How to use this class
    *   Set class in storyboard
    *  Make outlet
    *  use closure


## Features
     -  All states value are get through closure . Currently it support three states
     
     - Developer have the option to set any format .
     - Developer have option to set two type of format :
		    - First -> that to show on the Device.
				- Second -> format that to send on server .
	   These format can be set through Storyboard or code current date from textfield .
	
 ```swift
   @IBInspectable var uiDateFormat: String
   @IBInspectable var serverDateFormat: String
 ```
	   
## Codes

   In any class
   
``` swift
    
    @IBOutlet weak var txtDate: LeoUIDatePickerTextField!
    
    
    override func viewDidLoad() {
    
    super.viewDidLoad()
    
    
    txtDate.closureEditingDidBegin = { date in
    
    print("Some thing is closureEditingDidBegin" , date)
    
    }
    
    txtDate.closureValueChanged = { date in
    
    print("Some thing is changed" , date)
    
    
    }
    
    txtDate.closureEditingDidEnd = { 	date in
    
    print("Some thing is closureEditingDidEnd" , date)
    
    }
    
    }
    
    @IBAction func actionCurrentDate(_ sender: UIButton) {
    
    txtDate.setDate(date: Date(), animated: true)
    }
```

## UIPart

###  Date picker

![alt text](https://github.com/vijayvir/SwiftUtilities/blob/master/UIPickerDateTextfield/UIPickerDateTextfield/Assets.xcassets/DatePicker.imageset/Simulator%20Screen%20Shot%20Aug%2016%2C%202017%20at%201.21.11%20PM.png "Single Title Text 1")
    
    
    
##  Futher For this class
    - Add feature for max and min dates
    


### Any new suggestion , Please ping me at virvijay37@gmail.com



