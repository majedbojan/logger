# frozen_string_literal: true

require './lib/log_processors/base'

module LogProcessors
  class Parser < Base
    def initialize(log_file)
      super
      @log_file = read_file_into_array if success?
    end

    # NOTE: First I was using readlines but I noticed it constructs an empty array []
    # and repeatedly reads a line of file contents and pushes it to the array.
    # I thought each_line will solve performance issue for large file
    # but it looks it will be helpful when processing line by line and adding some logic which my structure doesn't
    # I would like to investigate more and come with better solution but couldn't do that due of lack of time
    # and balancing between the work pressure we have in these weeks in my current role
    # and coming with better solution to solve the technical test
    # @log_file = File.readlines(log_file) if success?
    def read_file_into_array
      arr = []
      log_file.each_line { |line| arr << line }
      arr
    end

    def perform
      result_parse = []

      log_file.each do |log|
        parser = log.split

        # If can't parse the log line for any reason.
        if parser.size != 2
          puts "Can't parse: #{log}\n\n"
          next
        end
        result_parse << json_builder(parser)
      end

      result_parse
    end

    private

    attr_reader :log_file

    def json_builder(parsed_line)
      {
        ip:        parsed_line[1],
        id:        id_scanner(parsed_line[0]),
        full_path: parsed_line[0],
        path:      path_scanner(parsed_line[0])
      }
    end

    def id_scanner(path)
      path.scan(/\d+/)[0]
    end

    def path_scanner(path)
      path.gsub(/(\d+|(min))/, '')
    end
  end
end
