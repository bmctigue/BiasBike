source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

target 'BiasBike' do

    pod 'RealmSwift'

    target 'BiasBikeTests' do
        inherit! :search_paths
    end
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        if target.name == 'Eureka'
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '4.2'
            end
        end
    end
end
