require 'rspec/core/rake_task'
require 'rexml/document'

def bukkit_version
  pom_file = File.new(File.join(File.dirname(__FILE__), "pom.xml"))
  REXML::Document.new(pom_file).tap do |doc|
    doc.elements.each("/project/properties/bukkit.version") {|e| return e.text }
  end
end

BUKKIT_VERSION = bukkit_version


RSpec::Core::RakeTask.new(:spec) do |t|
  t.ruby_opts = "-I#{File.join(File.dirname(__FILE__),'src','main','resources')} -r~/.m2/repository/org/bukkit/bukkit/#{BUKKIT_VERSION}/bukkit-#{BUKKIT_VERSION}.jar"
end

task :default => :spec
