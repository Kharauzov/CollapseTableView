Pod::Spec.new do |s|


s.platform = :ios
s.ios.deployment_target = '10.0'
s.name = "CollapseTableView"
s.summary = "CollapseTableView enables to expand sections with cells inside."
s.requires_arc = true
s.version = "1.0.3"
s.license = { :type => "MIT", :file => "LICENSE" }
s.author = { "Serhii Kharauzov" => "serhii.kharauzov@gmail.com" }
s.homepage = "https://github.com/Kharauzov/CollapseTableView"
s.source = { :git => "https://github.com/Kharauzov/CollapseTableView.git",
:tag => s.version }
s.framework = "UIKit"
s.source_files = "CollapseTableView/**/*.{swift}"
s.swift_version = "5.0"

end
