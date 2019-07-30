#  Extension of UIFont 



This class has two modifiers 

1.  `withName`: Change the font name of the target. 

```swift 
     label.font = label.font.withName(LeoFontNames.Arial.arial_ItalicMT.rawValue)
 
```

2.`withSize`: modify the size of the target.     

```swift  
   label.font =  label.font.withSize(30) 
```   
3.`leoMakeFontNameEnums`: Make the Enums for the all current fonts.     

```swift  
   UIFont.leoMakeFontNameEnums("SomeName")
```
  


