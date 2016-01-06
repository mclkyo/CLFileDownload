Pod::Spec.new do |s|  
  s.name             = "CLFileDownload" 
  s.version          = "0.4.3"  
  s.summary          = "Download Image or File With Cache "  
  s.description  = <<-DESC
			Download Web Image,first will cache in memoney and disk 
			Download Web File,will cache in disk 
                    DESC
  s.homepage         = "https://github.com/mclkyo/CLFileDownload"  
  s.license          = "MIT"  
  s.author           = { "mclkyo" => "mclkyo@gmail.com" }  
  s.source           = { :git => "https://github.com/mclkyo/CLFileDownload.git", :tag => "0.4.3"}  
  s.platform     = :ios, "7.0"  
  s.requires_arc = true  
  s.source_files = "Libs/*.{h,m}"

  
end