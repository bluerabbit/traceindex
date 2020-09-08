desc "Prints out missing indexes"
task :traceindex => :environment do
  traceindex   = Traceindex.new(Rails.application)
  column_names = traceindex.missing_index_column_names

  if column_names.size > 0
    puts "Missing index columns (#{column_names.size}):"
    column_names.each {|column| puts "  #{column}" }

    if ENV["FAIL_ON_ERROR"]
      raise "Missing indexes detected."
    end
  end
end
