# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LogProcessors::Analyzer do
  context 'when valid log file' do
    let!(:file) { File.open('spec/fixtures/webserver.log', 'r') }

    subject { described_class.new(file) }

    it 'returns success' do
      expect(subject.success?).to be_truthy
    end

    it 'must analyze the file and return an hash' do
      allow(described_class).to receive(:perform).and_return([])
      expect(subject.perform).to be_a(Hash)
    end

    it 'includes most_views key' do
      expect(subject.perform).to include(:most_views)
    end

    it 'includes unique_views key' do
      expect(subject.perform).to include(:unique_views)
    end

    it 'return 6 records for most web page views' do
      expect(subject.perform[:most_views].size).to eq(6)
    end

    it 'return 6 records for most unique web page views' do
      expect(subject.perform[:unique_views].size).to eq(8)
    end

    it 'must return data' do
      expect(subject.perform).not_to be_nil
    end
  end

  context 'when invalid log file' do
    subject { described_class.new('its not a file!') }

    it 'returns failure' do
      subject.perform
      expect(subject.success?).to be_falsey
    end

    it 'returns empty error msg' do
      subject.perform
      expect(subject.error_message).to eq('Expecting a file object as an argument, Invalid file format, only log files acceptable')
    end
  end
end
