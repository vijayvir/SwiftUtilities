  # How To use?
  ## There are some steps which are written below .
  • Add More dates format when you incounter in your code .
  ```
  LeoDates.share.addFormat("yyyy-MM-dd")
  LeoDates.share.addFormat("yyyy-MM-dd")
  
```
### From String  to Date or String

1.  Make sure your date format  is added to LeoDates.Share with above code
 
 ```
  let stringDate = "2019-09-08"
  print(stringDate.leoDateString(toFormat: "dd-MMMM-YYYY hh:mm a"))
 ``` 
  
  
  ### From Date to Date or String  
  ```
  let  someDate = Date()
  print(someDate.leoDateString(toFormat: "dd-MMMM-yyyy hh:mm:ss"))
```
