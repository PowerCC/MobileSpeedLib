Pod::Spec.new do |s|
  s.name = "MobileSpeedLib"
  s.version = "0.1.1"
  s.summary = "Mobile Speed Test."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"PowerCC"=>"zoucheng@live.cn"}
  s.homepage = "https://github.com/PowerCC/MobileSpeedLib"
  s.description = "TODO: Add long description of the pod here."
  s.xcconfig = {"OTHER_LDFLAGS"=>"-ObjC"}
  s.source = { :path => '.' }

  s.ios.deployment_target    = '10.0'
  s.ios.vendored_framework   = 'ios/MobileSpeedLib.framework'
end
