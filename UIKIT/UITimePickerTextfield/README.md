#  UIDatePickerTextfield

## Why this class is made ?
sometimes we need a time from date picker and to show this time in ui and pass to server's database.
In normal approach we make a textfield and the picker view and bind picker view data totext field  . This process is time consumming and for every screens , we have to copy paste the code . But in `LeoUITimePickerTextField` all things are bind in one class of textfiled and developer get the desire output in every state  through reactor approach .

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

@IBOutlet weak var txtTimePicker: LeoUITimePickerTextField!


override func viewDidLoad() {
super.viewDidLoad()

txtTimePicker.closureValueChanged = {
time in

print(time)

}
// Do any additional setup after loading the view, typically from a nib.
}

```

## UIPart

###  time  picker

![alt text]( https://github.com/vijayvir/SwiftUtilities/blob/master/UITimePickerTextfield/UITimePickerTextfield/Screen%20Shot%202017-08-16%20at%204.52.31%20PM.png  "Single Title Text 1")




### Any new suggestion , Please ping me at virvijay37@gmail.com



