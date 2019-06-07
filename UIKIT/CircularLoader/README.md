# Circular  loader view 

### About 
This view is used to  make circular loder with button action like `touchupInside` , `touchupDown`  and `touchUpOutside` 


### Swift code 

```Swift 
@IBOutlet weak var viewSome: LeoLongPressCircle!

viewSome.configure() .withDidEnd({
print("Ended")
}) .withDidStart({
print("Start")
}) .withDidTouchUpInSide({
print("withDidTouchUpInSide")
}).withDidTouchDown({
print("withDidTouchUpInSide")
})
.run()

```
