Pod::Spec.new do |s|
	
  s.name         = "CoreGraphicsExt"
  s.version      = "2.0.0"
  s.summary      = "A library extends CoreGraphics"

  s.description  = <<-DESC
                   CoreGraphics Extended Library is aiming to complete missing conveniences in CoreGraphics.
                   DESC

  s.homepage     = "https://github.com/WeZZard/Core-Graphics-Extended-Library"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "WeZZard" => "wezzardlau@gmail.com" }
  
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"

  s.source       = { :git => "https://github.com/WeZZard/Core-Graphics-Extended-Library.git", :tag => s.version.to_s }

  s.ios.source_files  = "Core-Graphics-Extended-Library", "Core-Graphics-Extended-Library-for-iOS"
  s.osx.source_files  = "Core-Graphics-Extended-Library", "Core-Graphics-Extended-Library-for-OS-X"
end
