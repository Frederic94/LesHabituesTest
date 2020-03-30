platform :ios, '10.0'
use_frameworks!

# Rx Stack
pod 'RxSwift', '~> 4.3.1'
pod 'RxCocoa', '~> 4.3.1'
pod 'RxDataSources', '~> 3.1.0'

target 'LesHabituesTest' do
    pod 'SwifterSwift'

    # navigation
    pod 'RxFlow', '~> 1.6.2'
    pod 'RxAlertController', '~> 4.0'

    #Networking
    pod 'Moya/RxSwift', '~> 11.0.2'

    #Database
    pod 'RealmSwift', '~> 3.20.0'
    pod 'RxRealm', '~> 0.7.6'

    target 'LesHabituesTestTests' do
        pod 'RxBlocking', '~> 4.4.0'
        pod 'RxTest', '~> 4.4.0'
    end
end

# related to: https://github.com/CocoaPods/CocoaPods/issues/5334
# this is a workarround
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CONFIGURATION_BUILD_DIR'] = '$PODS_CONFIGURATION_BUILD_DIR'
            # workarround for cocoapods 1.5.3: https://github.com/CocoaPods/CocoaPods/issues/7689
            config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
            #config.build_settings.delete('CODE_SIGNING_ALLOWED')
            config.build_settings.delete('CODE_SIGNING_REQUIRED')
        end
    end
end
