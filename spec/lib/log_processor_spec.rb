# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LogProcessor do
  context 'when valid log file' do
    let!(:log_file) { File.open('spec/fixtures/webserver.log', 'r') }

    subject { described_class.new(log_file) }

    it 'returns success' do
      subject.process
      expect(subject.analyzer.success?).to be_truthy
    end

    it 'returns empty error msg' do
      subject.process
      expect(subject.analyzer.error_message).to eq('')
    end

    it 'should return a nil' do
      expect(subject.process).to be_a(NilClass)
    end

    it 'should return viewed webpages as an array of hashes' do
      expect(subject.send(:most_views_response)).to eq([
                                                         { page: '/about/', views: 92 },
                                                         { page: '/contact', views: 89 },
                                                         { page: '/index', views: 82 },
                                                         { page: '/about', views: 81 },
                                                         { page: '/help_page/', views: 80 },
                                                         { page: '/home', views: 78 }
                                                       ])
    end

    it 'should return unique viewed webpages as an array of hashes' do
      expect(subject.send(:unique_views_response)).to eq([
                                                           { no_of_unique_views: 90, page: '/about/2' },
                                                           { no_of_unique_views: 89, page: '/contact' },
                                                           { no_of_unique_views: 82, page: '/index' },
                                                           { no_of_unique_views: 81, page: '/about' },
                                                           { no_of_unique_views: 80,
                                                             page:               '/help_page/1' },
                                                           { no_of_unique_views: 78, page: '/home' },
                                                           { no_of_unique_views: 1,
                                                             page:               '/about/3' },
                                                           { no_of_unique_views: 1,
                                                             page:               '/about/4' }
                                                         ])
    end
  end

  context 'when invalid argument' do
    subject { described_class.new('its not a file!') }

    it 'returns failure' do
      subject.process
      expect(subject.analyzer.success?).to be_falsey
    end

    it 'returns empty error msg' do
      subject.process
      expect(subject.analyzer.error_message).to eq('Expecting a file object as an argument, Invalid file format, only log files acceptable')
    end
  end
end
