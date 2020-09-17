$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'pry'
require 'rails'
require 'traceindex'
require_relative 'app'

RSpec.configure do |config|
  config.around do |example|
    ActiveRecord::Base.transaction do
      example.run

      raise ActiveRecord::Rollback
    end
  end
end
