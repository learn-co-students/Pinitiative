![alt-text](http://i.imgur.com/lJps0lY.png "Pinitiative")

# Pinitiative

Pinitiative is a project made for [The Opportunity Project](http://opportunity.census.gov/) using landmark data from NYC Open Data.


## Database Maker Application
This application uses another application to parse through NYC Open Data, geocode addresses, and write this organized data to Firebase. That app has [its own repository here.](https://github.com/Chrisb616/lemonHandshakeDatabaseMaker)

## How to get GeoFire 1.1 working
GeoFire hasn't been updated in some time. Until Firebase comes out with a new version for Swift 3, there are a few steps that need to be followed to get GeoFire up and running.

First of all, in your podfile, instead of writing the pod that GeoFire asks you to on their site, write the following:

`pod 'GeoFire', :git => 'https://github.com/firebase/geofire-objc.git'`

Now run `pod install` in  your terminal. When you open up the workspace, you'll find that you get an error reading 'FirebaseDatabase/FirebaseDatabase.h file not found' when you try to build.

To solve this, go to your navigator. Go to Pods > FirebaseDatabase > Frameworks > FirebaseDatabase.framework. 

![alt text](http://i.imgur.com/ZrVnvc0.png "Find the FirebaseDatabase.framework")

Select that file. In the utilities, inside of the File Inspector, check the box inside Target Membership that reads "GeoFire". 

![alt text](http://i.imgur.com/KkoB6WW.png "Set the GeoFire Framwork to require.")

As our repository has a .gitignore that ignores our pods, this has to be done each time you clone the project.
