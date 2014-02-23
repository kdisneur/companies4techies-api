require './lib/core_ext/deep_struct'
require 'erb'
require 'yaml'

class Configuration < DeepStruct
  def initialize(environment)
    environment = 'development' unless environment

    configuration_stream = ERB.new(IO.read("config/#{filename}")).result
    super(YAML.load(configuration_stream)[environment])
  end
end
