# frozen_string_literal: true

# require_relative '../lib/log_processor/analyzer'
require_relative '../lib/log_processors/analyzer'

class LogProcessor
  # def initialize(log_file)
  #   @log_file = log_file
  # end

  def self.process
    new.process
  end

  def process
    results = LogProcessors::Analyzer.perform

    # puts "Total number of requests: "
    puts 'list of webpages with most page views ordered from most pages views to less page views'
    results[:most_views].each do |record|
      p "#{record[:page]} #{record[:views]} visits"
    end

    puts 'list of webpages with most unique page views also ordered'
    results[:unique_views].each do |record|
      p "#{record[:page]} #{record[:no_of_unique_views]} visits"
    end
  end
end

