module Loggable
  def process_data
    puts "Logging: Starting data processing"
    super
    puts "Logging: Finished data processing"
  end
end

class DataProcessor
  prepend Loggable

  def process_data
    puts "Processing the actual data"
  end
end

class SimpleProcessor
  include Loggable

  def process_data
    puts "Simple processing"
    super rescue puts "No super method found"
  end
end

puts "With prepend:"
DataProcessor.new.process_data

puts "\nWith include:"
SimpleProcessor.new.process_data
