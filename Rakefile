require 'rbconfig'
require 'rake/testtask'
require 'rubygems'
require 'bundler'
Bundler.setup
require 'wd_sinatra/app_loader'

root = File.expand_path(File.dirname(__FILE__))

Rake::TestTask.new do |t|
  t.libs << "."
  t.libs << 'test'
  t.pattern = "test/**/*_test.rb"
end

task :default => :test

# boot the app
task :setup_app do
  ENV['DONT_CONNECT'] ||= 'true'
  begin
    WDSinatra::AppLoader.setup(root)
  rescue Exception => e
    if defined?(ActiveRecord) && e.is_a?(ActiveRecord::ConnectionNotEstablished)
      ENV['DONT_CONNECT'] == 'true' ? print(e.message+"\n") : raise(e)
    else
      raise(e)
    end
  end
end

task :console => :setup_app do
  require 'pry'
  Pry.start
end

task :environment do
  ENV['DONT_CONNECT'] = nil
  WDSinatra::AppLoader.setup(root)
  WDSinatra::AppLoader.server(Kibitz)
end

desc "Print the available routes"
task :routes do
  WDSinatra::AppLoader.setup(root)
  print "Available routes: \n"
  WSList.all.each do |service|
    print "#{service.http_verb.upcase}\t#{service.url}\n"
  end
end

WDSinatra::AppLoader.set_loadpath(root)
Dir.glob("lib/tasks/**/*.rake").each do |task_file|
  load task_file
end
