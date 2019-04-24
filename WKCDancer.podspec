Pod::Spec.new do |s|
s.name         = "WKCDancer"
s.version      = "1.5.6"
s.summary      = "The animation is loaded in a chained manner. The following functions are classified by MARK"
s.homepage     = "https://github.com/WKCLoveYang/WKCDancer.git"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author             = { "WKCLoveYang" => "wkcloveyang@gmail.com" }
s.platform     = :ios, "9.0"
s.source       = { :git => "https://github.com/WKCLoveYang/WKCDancer.git", :tag => "1.5.6" }
s.source_files  = "WKCDancer/**/*.{h,m}"
s.public_header_files = "WKCDancer/**/*.h"
s.frameworks = "Foundation", "UIKit"
s.requires_arc = true
end
