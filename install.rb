require 'fileutils'

slideshow_css = File.dirname(__FILE__) + '/../../../public/stylesheets/slideshow.css'

FileUtils.cp(File.dirname(__FILE__) + '/public/stylesheets/slideshow.css', slideshow_css) unless File.exists?(slideshow_css)
