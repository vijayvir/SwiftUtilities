#  Custom Regex functions

`NSRegularExpression` api compares the given text with given pattern and give the results based on applied function's return value .

#LeoRegex
 This is custom regex class which have regular Expressions patterns that are commonly used in basic projects . This class will be modified time to time .
 
### Following features are available in this class 
  ``` swift 
  enum LeoRegexType {
    case email
    case userName
    case password
    case hexValue
		case url
		case ipAddress
		case phoneNumberUSA
		case other
		case alphabets
		}  
	}
  ```
  
### How to use?
 There is custom `infix operator`  `=^` which  gives a return value as `BOOl`
 
  **Why =^ used as operator**. As regular Expression is different [Topic](https://code.tutsplus.com/tutorials/8-regular-expressions-you-should-know--net-6149 "Title") , but as abstract , it's equations(or pattern) are start with `^` and ends with `$` . So for easy  `=^` is used as operator. 
  
```swift
  		if "SomePattern" =^ LeoRegex.LeoRegexType.alphabets.pattern {
       print("Is have alphabets.")
		} else {
      print("Is not  have alphabets.")
		}
 
```
 

  

  

 
 