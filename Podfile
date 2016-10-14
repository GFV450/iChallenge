# Uncomment this line to define a global platform for your project
  platform :ios, '9.0'

target 'iChallenge' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for iChallenge
  pod 'Firebase'
  pod 'Firebase/Auth'
  pod 'Firebase/Database'
  pod 'Firebase/Storage'
#  pod 'AlamofireImage', '~> 2.0'
  pod 'Alamofire',
    :git => 'https://github.com/Alamofire/Alamofire.git',
    :branch => 'master'
  pod 'Material', # '~> 1.0'
    :git => 'https://github.com/CosmicMind/Material.git',
    :branch => 'development'
  pod 'SDWebImage’, ’~> 3.8’
#  pod 'Spring', :git => 'https://github.com/MengTo/Spring.git', :branch => 'swift2'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
