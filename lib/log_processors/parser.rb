# frozen_string_literal: true

module LogProcessors
  class Parser < Base
    def self.parse(logs)
      new(logs).parse
    end

    def parse
      result_parse = []

      logs.each do |log|
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

# require 'pry'
# path = '/Users/majed/sites/technical_test/logger/seed/webserver.log'
# logs = File.readlines(path)
# Parser.parse(logs)
