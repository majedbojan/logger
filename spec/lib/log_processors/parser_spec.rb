# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LogProcessors::Parser do
  context 'when valid log file' do
    let!(:file) { File.open('spec/fixtures/webserver.log', 'r') }
    let!(:log_file_with_five_lines) { File.open('spec/fixtures/log_file_with_five_lines.log', 'r') }

    subject { described_class.new(file) }

    it 'returns success' do
      expect(subject.success?).to be_truthy
    end

    it 'must parse the file' do
      allow(described_class).to receive(:perform).and_return([])
      expect(subject.perform).to be_a(Array)
    end

    it 'returns correct number of lines' do
      expect(subject.perform.size).to eq(File.readlines(file).count)
    end

    it 'should return array of hashes' do
      expect(described_class.new(log_file_with_five_lines).perform).to eq([
                                                                            {
                                                                              full_path: '/help_page/1', id: '1',
                                                                              ip: '126.318.035.038', path: '/help_page/'
                                                                            },
                                                                            {
                                                                              full_path: '/contact', id: nil,
                                                                              ip: '184.123.665.067', path: '/contact'
                                                                            },
                                                                            {
                                                                              full_path: '/home', id: nil,
                                                                              ip: '184.123.665.067', path: '/home'
                                                                            },
                                                                            {
                                                                              full_path: '/about/2', id: '2',
                                                                              ip: '444.701.448.104', path: '/about/'
                                                                            },
                                                                            {
                                                                              full_path: '/help_page/1', id: '1',
                                                                              ip: '929.398.951.889', path: '/help_page/'
                                                                            }
                                                                          ])
    end
  end

  context 'when invalid log file' do
    let!(:empty_file) { File.open('spec/fixtures/empty_log_file.log', 'r') }
    let!(:file_with_wrong_extention) { File.open('spec/fixtures/file_with_wrong_extention.json', 'r') }

    context 'when unexpected file extention' do
      subject { described_class.new(file_with_wrong_extention) }

      it 'returns failure' do
        expect(subject.success?).to be_falsey
      end

      it 'returns error message' do
        expect(subject.error_message).to eq('Invalid file format, only log files acceptable')
      end
    end

    context 'when empty file' do
      subject { described_class.new(empty_file) }
      it 'returns failure' do
        expect(subject.success?).to be_falsey
      end

      it 'returns error message' do
        expect(subject.error_message).to eq('Cannot process empty file')
      end
    end

    context 'when its not a file' do
      subject { described_class.new('its not a file!') }

      it 'returns failure' do
        expect(subject.success?).to be_falsey
      end

      it 'returns error message' do
        expect(subject.error_message).to eq('Expecting a file object as an argument, Invalid file format, only log files acceptable')
      end
    end
  end
end
