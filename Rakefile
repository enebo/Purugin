require 'rspec/core/rake_task'

# FIXME: This sucks.  We should be single-sourcing this from here or maven.
# Right now this version number is in one Java source file,  Maven pom, 
# and here.
BUKKIT_VERSION = '1.4.7-R1.0'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.ruby_opts = "-I#{File.join(File.dirname(__FILE__),'src','main','resources')} -r~/.m2/repository/org/bukkit/bukkit/#{BUKKIT_VERSION}/bukkit-#{BUKKIT_VERSION}.jar"
end

task :default => :spec
