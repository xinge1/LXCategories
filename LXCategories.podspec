#
#  Be sure to run `pod spec lint LXCategories.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

    s.name         = "LXCategories"
    s.version      = "0.0.7"
    s.ios.deployment_target = '8.0'
    s.summary      = "一个iOS开发常用的分类工具库。"
    s.homepage     = "https://github.com/xinge1/LXCategories"
    s.social_media_url = 'https://github.com/xinge1/LXCategories'
    s.license      = "MIT"
    # s.license    = { :type => "MIT", :file => "FILE_LICENSE" }
    s.author       = { "xinge1" => "3093496743@qq.com" }
    s.source       = { :git => 'https://github.com/xinge1/LXCategories.git', :tag => s.version}
    s.requires_arc = true
    s.source_files = 'LXCategories/**/*.{h,m}'
    s.public_header_files = 'LXCategories/**/*.{h}'

end
