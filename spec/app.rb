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
  YAML.load(ERB.new(File.read('spec/database.yml')).result)['test']
)

ActiveRecord::Schema.define version: 0 do
  create_table :users, force: true do |t|
    t.references :created_user,    foreign_key: { to_table: :users }
    t.integer    :updated_user_id, index: false
  end
end

class User < ActiveRecord::Base
end
