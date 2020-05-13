#
# Be sure to run `pod lib lint MobileSpeedLib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MobileSpeedLib'
  s.version          = '0.1.1'
  s.summary          = 'Mobile Speed Test.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/PowerCC/MobileSpeedLib'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zoucheng@live.cn' => 'zoucheng@baihe.com' }
  s.source           = { :git => 'https://github.com/PowerCC/MobileSpeedLib.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'MobileSpeedLib/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MobileSpeedLib' => ['MobileSpeedLib/Assets/*.png']
  # }

  # s.public_header_files = 'MobileSpeedLib/Classes/MobileSpeedLib.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AFNetworking'
  s.dependency 'GBDeviceInfo'
  s.dependency 'PhoneNetSDK'
  s.dependency 'CocoaAsyncSocket'
  s.dependency 'INTULocationManager'
  s.dependency 'JSONModel'
  s.dependency 'MBProgressHUD'
  s.dependency 'FCUUID'
end
