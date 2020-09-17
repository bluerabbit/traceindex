# frozen_string_literal: true

require 'rails/all'
require 'action_controller/railtie'

require 'traceindex'

module DummyApp
  class Application < Rails::Application
    config.root = File.expand_path(__dir__)
  end
end

ActiveRecord::Base.establish_connection(
  YAML.load(File.read('spec/database.yml'))['test']
)

ActiveRecord::Schema.define version: 0 do
  create_table :users, force: true do |t|
    t.integer :created_user_id, index: true
    t.integer :updated_user_id, index: false
  end
end

class User < ActiveRecord::Base
end
