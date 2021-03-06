namespace :doc do
  desc "Generate documentation for the web services"
  task :services do
    ENV['DONT_CONNECT'] = 'true'
    ENV['DONT_PRINT_ROUTES'] = 'true'
    require 'wd_sinatra/app_loader'
    root = File.expand_path("../..", File.dirname(__FILE__))
    WDSinatra::AppLoader.setup(root)
    WDSinatra::AppLoader.server(Kibitz)
    LOGGER.level = Logger::FATAL

    require 'fileutils'
    destination = File.join(root, 'doc')
    FileUtils.mkdir_p(destination) unless File.exist?(destination)
    File.open("#{destination}/index.html", "w"){|f| f << doc_template.result(binding)}
    puts "Documentation available there: #{destination}/index.html"
    `open #{destination}/index.html` if RUBY_PLATFORM =~ /darwin/ && !ENV['DONT_OPEN']
  end

  def response_element_html(el)
    response_element_template.result(binding)
  end

  def input_params_html(required, optional)
    input_params_template.result(binding)
  end

  def input_params_template
    file = resources.join '_input_params.erb'
    ERB.new File.read(file)
  end

  def response_element_template
    file = resources.join '_response_element.erb'
    ERB.new File.read(file)
  end

  def doc_template
    file = resources.join 'template.erb'
    ERB.new File.read(file)
  end

  def resources
    require 'pathname'
    @resources ||= Pathname.new(File.join(File.dirname(__FILE__), 'doc_generator'))
  end

end
