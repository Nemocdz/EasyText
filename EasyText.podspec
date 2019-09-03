#
# Be sure to run `pod lib lint EasyText.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'EasyText'
  s.version          = '1.0.0'
  s.summary          = 'Easy way to use attributedString on Swift 5'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Nemocdz/EasyText'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Nemocdz' => 'nemocdz@gmail.com' }
  s.source           = { :git => 'https://github.com/Nemocdz/EasyText.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.swift_versions = ['5.0', '5.1']
  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.11'

  s.source_files = ['EasyText/*.swift', 'EasyText/EasyText.h']
  s.public_header_files = 'EasyText/EasyText.h'

  # s.resource_bundles = {
  #   'EasyText' => ['EasyText/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
