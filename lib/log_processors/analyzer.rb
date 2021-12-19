# frozen_string_literal: true

require './lib/log_processors/base'

module LogProcessors
  class Analyzer < Base
    def logs
      [
        { ip: "126.318.035.038\n", id: '1', full_path: '/help_page/1', path: '/help_page/' },
        { ip: "126.318.035.038\n", id: '2', full_path: '/help_page/2', path: '/help_page/' },
        { ip: "184.123.665.067\n", id: nil, full_path: '/contact', path: '/contact' },
        { ip: "184.123.665.067\n", id: nil, full_path: '/home', path: '/home' },
        { ip: "444.701.448.104\n", id: '2', full_path: '/about/2', path: '/about/' },
        { ip: "929.398.951.889\n", id: '1', full_path: '/help_page/1', path: '/help_page/' },
        { ip: "444.701.448.104\n", id: nil, full_path: '/index', path: '/index' },
        { ip: "722.247.931.582\n", id: '1', full_path: '/help_page/1', path: '/help_page/' },
        { ip: "061.945.150.735\n", id: nil, full_path: '/about', path: '/about' },
        { ip: "646.865.545.408\n", id: '1', full_path: '/help_page/1', path: '/help_page/' },
        { ip: "235.313.352.950\n", id: nil, full_path: '/home', path: '/home' }
      ]
    end

    def perform
      {
        most_views:   most_views.sort_by! { |k| -k[:views] },
        unique_views: unique_views.sort_by! { |k| -k[:no_of_unique_views] }
      }
    end

    private

    def webpages
      logs.group_by { |h| h[:path] }
    end

    # This one resulting wrong respnse pls read the doc
    def unique_views
      webpages.map do |web_pages, viewed_pages|
        {
          page:               web_pages,
          no_of_unique_views: viewed_pages.map { |page| page[:id] }.uniq.size
        }
      end
    end

    def most_views
      webpages.map do |web_pages, viewed_pages|
        {
          page:  web_pages,
          views: viewed_pages.size
        }
      end
    end
  end
end
