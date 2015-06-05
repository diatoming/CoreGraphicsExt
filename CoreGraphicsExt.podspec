Pod::Spec.new do |s|
	
  s.name         = "CoreGraphicsExt"
  s.version      = "0.0.1"
  s.summary      = "A library extends CoreGraphics"

  s.description  = <<-DESC
                   CoreGraphics Extended Library is aiming to complete missing conveniences in CoreGraphics.
                   DESC

  s.homepage     = "https://github.com/WeZZard/Core-Graphics-Extended-Library"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "WeZZard" => "wezzardlau@gmail.com" }
  
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/WeZZard/Core-Graphics-Extended-Library.git", :tag => "0.0.1" }

  s.source_files  = "Core\ Graphics\ Extended\ Library", "Core\ Graphics\ Extended\ Library\ for\ iOS", "Core\ Graphics\ Extended\ Library\ for\ OS\ X"

  s.requires_arc = true

end
