# frozen_string_literal: true

module LogProcessors
  # def initialize(logs)
  #   @logs = logs
  # end
  class Base
    def self.perform
      new.perform
    end

    def perform
      raise NotImplementedError
    end

    private

    attr_reader :logs

    def file_reader
      @logs = File.readlines(path)
    end
  end
end
