# frozen_string_literal: true

module LogProcessors
  class Base
    def initialize(log_file)
      @log_file = log_file
      @errors = []
      validate_log_file!
    end

    def perform
      raise NotImplementedError
    end

    def success?
      errors.empty?
    end

    def error_message
      errors.join(', ')
    end

    private

    attr_reader :log_file, :errors

    def validate_log_file!
      validate_arguments!
      validate_file_extension!
      validate_if_file_is_empty!
    end

    def validate_arguments!
      errors.push('Expecting a file object as an argument') unless log_file.is_a?(File)
    end

    def validate_file_extension!
      ext = File.extname(log_file)
      errors.push('Invalid file format, only log files acceptable') unless ext.casecmp('.log').zero?
    end

    def validate_if_file_is_empty!
      errors.push('Cannot process empty file') if File.zero?(log_file)
    end
  end
end
