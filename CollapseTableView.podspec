Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '10.0'
s.name = "CollapseTableView"
s.summary = "CollapseTableView enables to expand sections with cells inside."
s.requires_arc = true

# 2
s.version = "1.0.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Serhii Kharauzov" => "serhii.kharauzov@gmail.com" }

# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/Kharauzov/CollapseTableView"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/Kharauzov/CollapseTableView.git",
:tag => s.version }

# 7
s.framework = "UIKit"

# 8
s.source_files = "Source/*.swift"

# 10
s.swift_version = "5.0"

end
