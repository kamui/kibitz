class Kibitz < Sinatra::Base
  set :environment, RACK_ENV
  set :root, WDSinatra::AppLoader.root_path
  set :app_file, __FILE__
  set :public_folder, File.join(WDSinatra::AppLoader.root_path, "public")
  set :method_override, true

  # enable logging in certain environments
  configure :development, :production do
    enable :logging
  end

  # Checks on static files before dispatching calls
  enable :static

  # enable rack session
  enable :session

  set :raise_errors, false

  # enable that option to run by calling this file automatically (without using the config.ru file)
  # enable :run

  # Store the caught exception in the rack env so it can be used
  # by 3rd party apps like airbrake.
  error(::Exception) do |exception|
    @env['rack.exception'] = exception
  end

  # Use this middleware with AR to avoid threading issues.
  # require 'active_record'
  # use ActiveRecord::ConnectionAdapters::ConnectionManagement

  use Airbrake::Rack if defined?(Airbrake)

  use Rack::ContentLength

  require "rack/parser"
  use Rack::Parser

  if defined?(NewRelic)
    #if RACK_ENV == 'development'
      #require 'new_relic/rack/developer_mode'
      #use NewRelic::Rack::DeveloperMode
    #end
    if NewRelic::Agent.config[:agent_enabled]
      LOGGER.info "New Relic monitoring enabled App name: '#{NewRelic::Control.instance['app_name']}', Mode: '#{NewRelic::Control.instance.app}'"
    end
  end
end
