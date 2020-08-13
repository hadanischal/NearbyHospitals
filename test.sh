xcodebuild \
-workspace NearbyHospitals.xcworkspace \
-scheme NearbyHospitals \
-sdk iphonesimulator \
-destination 'platform=iOS Simulator,name=iPhone 11 Pro Max,OS=13.6' \
test | xcpretty
