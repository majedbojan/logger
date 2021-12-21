# frozen_string_literal: true

require './lib/log_processors/base'

module LogProcessors
  class Parser < Base
    def initialize(log_file)
      super
      @log_file = File.readlines(log_file) if success?
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
