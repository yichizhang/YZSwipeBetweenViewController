Pod::Spec.new do |s|
  s.name         = "YZSwipeBetweenViewController"
  s.version      = "0.0.1"
  s.summary      = "A view controller that has a scroll view which contains multiple view controllers's views; user can swipe left/right to switch to different views."
  s.homepage     = "https://github.com/yichizhang/" + s.name
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Yichi Zhang" => "zhang-yi-chi@hotmail.com" }
  s.source       = {
    :git => "https://github.com/yichizhang/" + s.name + ".git",
    :tag => s.version.to_s
  }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Source/*.{h,m}'
  #s.resources    = 'RES.bundle'

  s.framework  = 'Foundation', 'UIKit'

end
