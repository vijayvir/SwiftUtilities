#  LeoPickerColumn 

Sometime there is need of picker, which have upper and lower limit. Eg need for  timer , hours , minutes or  extra custom picker values . This class provide the feature to  


## How to use ? 

``` swift 
   	@IBOutlet weak var leoPickerColumnHours: LeoPickerColumn!
   	
   			
   	leoPickerColumnHours.configure(withValue: 0)
   			
   	leoPickerColumnHours.closureDidValueSet = { value in
          
		}

```

`configure(withValue: 0)` is used to set the initial value . to the picker 

`closureDidValueSet` is  called , whenever the value is set or change in picker 


### Other features 

  1 Set the max and min values in storyboard 
  2 Automatically buttons get disable and enable when upper or lower limits reached. 
  3  There is option for time , where it can show 12' clock format in label 
  
 