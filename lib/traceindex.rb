class Traceindex
  VERSION = Gem.loaded_specs['traceindex'].version.to_s

  class Railtie < ::Rails::Railtie
    rake_tasks do
      load File.join(File.dirname(__FILE__), "tasks/traceindex.rake")
    end
  end

  def initialize(app)
    @app                 = app
    @ignore_models       = (config["ignore_models"] || [])
    @ignore_columns      = (config["ignore_columns"] || [])
    @ignore_foreign_keys = (config["ignore_foreign_keys"] || [])
    @ignore_tables       = (config["ignore_tables"] || [])
  end

  def missing_index_column_names
    models.each.with_object([]) do |model, missing_index_columns|
      id_columns = model.columns.select {|column| column.name.end_with?("_id") }

      indexes = ActiveRecord::Base.connection.indexes(model.table_name)

      id_columns.each do |id_column|
        if @ignore_columns.include?("#{model.table_name}.#{id_column.name}")
          next
        end

        next unless indexes.none? {|index| index.columns.first == id_column.name }

        missing_index_columns << "#{model.table_name}.#{id_column.name}"
      end
    rescue => e
      puts e.message
    end
  end

  def missing_foreign_keys
    models.each.with_object([]) do |model, missing_columns|
      id_columns = model.columns.select {|column| column.name.end_with?("_id") }

      foreign_keys = ActiveRecord::Base.connection.foreign_keys(model.table_name)

      id_columns.each do |id_column|
        if @ignore_foreign_keys.include?("#{model.table_name}.#{id_column.name}")
          next
        end

        next unless foreign_keys.none? { |index| index.column == id_column.name }
        missing_columns << "#{model.table_name}.#{id_column.name}"
      end
    rescue => e
      puts e.message
    end
  end

  private

  def config_filename
    %w[.traceindex.yaml .traceindex.yml].detect {|f| File.exist?(f) }
  end

  def config
    @config ||= config_filename ? YAML.load_file(config_filename) : {}
  end

  def models
    return @models if @models

    @app.eager_load!
    @models ||= ActiveRecord::Base.descendants.reject(&:abstract_class).reject do |model|
      @ignore_models.include?(model.name) || @ignore_tables.include?(model.table_name)
    end
  end
end
