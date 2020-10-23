desc 'Prints out missing indexes'
task traceindex: :environment do
  traceindex   = Traceindex.new(Rails.application)
  column_names = traceindex.missing_index_column_names

  unless column_names.empty?
    puts "Missing index columns (#{column_names.size}):"
    column_names.each { |column| puts "  #{column}" }
  end

  if ENV['IGNORE_FOREIGN_KEY'].nil?
    fk_column_names = traceindex.missing_foreign_keys

    unless fk_column_names.empty?
      puts "Missing foreign keys (#{fk_column_names.size}):"
      fk_column_names.each { |column| puts "  #{column}" }
    end
  end

  if ENV['FAIL_ON_ERROR'] && (!column_names.empty? || !fk_column_names.empty?)
    raise 'Missing indexes detected.'
  end
end
