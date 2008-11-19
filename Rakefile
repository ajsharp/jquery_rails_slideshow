require 'rake'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Generate documentation for the jquery_rails_slideshow plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'JqueryRailsSlideshow'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
