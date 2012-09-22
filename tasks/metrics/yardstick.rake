begin
  require 'pathname'
  require 'yardstick'
  require 'yardstick/rake/measurement'
  require 'yardstick/rake/verify'
  require 'yaml'

  config = YAML.load_file(File.expand_path('../../../config/yardstick.yml', __FILE__))
  path = config.fetch('path', 'lib/**/*.rb')
  # yardstick_measure task
  Yardstick::Rake::Measurement.new do |measurement|
    measurement.path = path 
  end

  # verify_measurements task
  Yardstick::Rake::Verify.new do |verify|
    verify.threshold = config.fetch('threshold')
    verify.path = path
  end
rescue LoadError
  %w[ yardstick_measure verify_measurements ].each do |name|
    task name.to_s do
      abort "Yardstick is not available. In order to run #{name}, you must: gem install yardstick"
    end
  end
end
