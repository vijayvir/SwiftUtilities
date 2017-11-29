

### Main purpose of this class is to store images in file managers and store paths in array and return that array of paths*  to class through  delegate  or closure

## paths*  :  images are going to save in /tmp/UIMultiplePhoto/  of app

## to empty the UIMultiplePhoto follder use class function : removeCache()


 Use this below line to .plist .Why? To have access from the user to open the Gallery or Camera
```code
<key>NSCameraUsageDescription</key>
<string>Access needed to use your camera.</string>

<key>NSPhotoLibraryUsageDescription</key>
<string>Access needed to photo gallery.</string>


```

## Working of the class

```swift
// Ist : make the outlet in class
@IBOutlet weak var btnPhoto: UIPhotosButton!


// 2nd : use the closure or delegate in view Did load method .

btnPhoto.closureDidFinishPickingAnImage = { image in

print(image)

DispatchQueue.main.async {

let url : URL = URL(fileURLWithPath: image.first!)

Nuke.loadImage(with: url, into: self.imgeVUerPic)

}
}
```
## UIPart
### Single Image
![alt text](https://github.com/vijayvir/SwiftUtilities/blob/master/UIbutton/UIbutton/Simulator%20Screen%20Shot%20-%20iPhone%207%20Plus%20-%202017-08-11%20at%2015.41.55.png "Single Title Text 1")

###  UIMultiplePhoto Image

![alt text](https://github.com/vijayvir/SwiftUtilities/blob/master/UIbutton/UIbutton/Simulator%20Screen%20Shot%20-%20iPhone%207%20Plus%20-%202017-08-11%20at%2015.42.21.png "UIMultiplePhoto Title Text 1")
