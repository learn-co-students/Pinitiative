platform :ios, '9.0'
use_frameworks!

target 'LemonHandshake' do

pod 'Firebase'
pod 'Firebase/Auth'
pod 'Firebase/Database'
pod 'Mapbox-iOS-SDK', '~> 3.3.6'
pod 'SnapKit', '~> 3.0.2'
pod 'FirebaseUI'
pod 'GoogleSignIn'
pod 'GeoFire', :git => 'https://github.com/firebase/geofire-objc.git'
pod 'JSQMessagesViewController', '~> 7.3'
pod 'Former'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
        
        if target.name == "GeoFire"
            target.build_configurations.each do |config|
                config.build_settings["FRAMEWORK_SEARCH_PATHS"] = '$(inherited) "${SRCROOT}/FirebaseDatabase/Frameworks"'
                config.build_settings["HEADER_SEARCH_PATHS"] = '$(inherited) "${PODS_ROOT}/Headers/Public/FirebaseDatabase"'
                config.build_settings["OTHER_CFLAGS"] = '$(inherited) -isystem "${PODS_ROOT}/Headers/Public/FirebaseDatabase"'
                config.build_settings["OTHER_LDFLAGS"] = '$(inherited) -framework "FirebaseDatabase"'
            end
        end
        
    end
end
