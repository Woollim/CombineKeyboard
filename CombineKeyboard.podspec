#
# Be sure to run `pod lib lint CombineKeyboard.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CombineKeyboard'
  s.version          = '1.0.0'
  s.summary          = 'A way to getting iOS keyboard information with Combine'
  s.homepage         = 'https://github.com/Woollim/CombineKeyboard'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Woollim' => 'galaxy000213@gmail.com' }
  s.source           = { :git => 'https://github.com/Woollim/CombineKeyboard.git', :tag => s.version.to_s }
	s.frameworks = 'UIKit', 'Foundation', 'Combine'
	s.platform = :ios, '13.0'
  s.source_files = 'CombineKeyboard/*.swift'
	s.swift_versions = "5.0"
end
