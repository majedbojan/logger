# frozen_string_literal: true

require './lib/log_processors/base'
require './lib/log_processors/parser'

module LogProcessors
  class Analyzer < Base
    def perform
      return {} unless parser.success?

      {
        most_views:   most_views.sort_by! { |k| -k[:views] },
        unique_views: unique_views.sort_by! { |k| -k[:no_of_unique_views] }
      }
    end

    private

    def parser
      LogProcessors::Parser.new(log_file)
    end

    def logs
      @logs ||= parser.perform
    end

    def webpages(order_by)
      logs.group_by { |h| h[order_by.to_sym] }
    end

    def unique_views
      webpages_group_by_full_path.map do |page, viewed_pages|
        {
          page:               page,
          no_of_unique_views: viewed_pages.map { |v_page| v_page[:id] }.size
        }
      end
    end

    def most_views
      webpages_group_by_path.map do |page, viewed_pages|
        {
          page:  page,
          views: viewed_pages.size
        }
      end
    end

    def webpages_group_by_path
      logs.group_by { |l| l[:path] }
    end

    def webpages_group_by_full_path
      logs.group_by { |l| l[:full_path] }
    end
  end
end
