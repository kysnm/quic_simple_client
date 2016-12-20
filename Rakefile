require "bundler/gem_tasks"
require "rake/extensiontask"

task :build => :compile

Rake::ExtensionTask.new("quic_simple_client") do |ext|
  ext.lib_dir = "lib/quic_simple_client"
end

task :default => [:clobber, :compile, :spec]
