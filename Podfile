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
pod 'JSQMessagesViewController'
pod 'JSQMessagesViewController', '~> 7.3'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
