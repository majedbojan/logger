# frozen_string_literal: true

require_relative '../lib/log_processors/analyzer'

class LogProcessor
  attr_reader :analyzer

  def initialize(log_file_path)
    @analyzer = LogProcessors::Analyzer.new(log_file_path)
    @response = analyzer.perform
  end

  def process
    if analyzer.success?
      most_views_response
      unique_views_response
    else
      p analyzer.error_message
    end

    GC.start
  end

  private

  attr_reader :response

  def most_views_response
    puts 'List of webpages with most page views ordered from most pages views to less page views'
    response[:most_views].each do |record|
      p "#{record[:page].ljust(30)} #{record[:views]} visits"
    end
  end

  def unique_views_response
    puts 'List of webpages with most unique page views ordered from most pages views to less page views'
    response[:unique_views].each do |record|
      p "#{record[:page].ljust(30)} #{record[:no_of_unique_views]} visits"
    end
  end
end
