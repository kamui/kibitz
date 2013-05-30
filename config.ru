require 'rubygems'
require 'wd_sinatra/app_loader'
root = File.expand_path(File.dirname(__FILE__))
WDSinatra::AppLoader.setup(root)
WDSinatra::AppLoader.server(Kibitz)
map("/") { run Kibitz }
