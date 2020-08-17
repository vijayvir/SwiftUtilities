#  Constant markup

### DateFormat used in project

## Commands 

sourcekitten doc -- -workspace FuelVCO.xcworkspace -scheme FuelVCO > swiftDoc.json
jazzy --sourcekitten-sourcefile swiftDoc.json --min-acl internal
