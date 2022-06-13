Pod::Spec.new do |s|
  s.name             = 'XYStatistic'
  s.version          = '1.0.1'
  s.summary          = 'XY Statistic'

  s.description      = <<-DESC
						XY Statistic for iOS
                       DESC

  s.homepage         = 'https://github.com/tospery/XYStatistic'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'YangJianxiang' => 'tospery@gmail.com' }
  s.source           = { :git => 'https://github.com/tospery/XYStatistic.git', :tag => s.version.to_s }

  s.requires_arc = true
  s.swift_version = '5.0'
  s.ios.deployment_target = '11.0'
  
  s.frameworks = 'Foundation'
  s.source_files = 'XYStatistic/**/*'
  
  s.dependency 'SWFrame/Core', '2.1.3'
  s.dependency "Alamofire", "~> 5.0"
end
