#  LeoAnySelectableTextField

In this class user can selecte single and multiple options from the tableview and show the text according to his choice in the textfield  in the closure 



### code 

```swift 
txtField2.configure(withElements: [first , second , third  , first1 , second1 , third1])
.withClosureDidSelectElements { (elements) in

let osme = elements.reduce("", { (result, elemeent) -> String in

return result +  "," + elemeent.leoTitle
})

self.txtField2.text = osme

print(elements.count)

}.withStop()
```

* In `configure ` function pass the data you want to pass. Make sure the class is conform to `LeoSelectable` protocol 

*  Protocol `LeoSelectable `   
```swift 
@objc protocol  LeoSelectable  : class {
    
    var leoIsSelected  : Bool {get set }
    
    var leoTitle : String { get  }
 
    @objc optional var leoDetailText : String? { get  }
   
    @objc optional var leoImage : UIImage? { get  }
}
```
 The protocol have the 4 properties
 `leoIsSelected ` and  leoTitle are the mandatory one,  other two are optional 
 
* `selectedElements `  with this variable user can access the selected elements from textfield object 
* `isSingleSelection` with this property from interface or with code developer can change the functionilty from Multiple selection to Single selection 
* `tintColorLeo` Developer can change the tint color of the controls 

 

