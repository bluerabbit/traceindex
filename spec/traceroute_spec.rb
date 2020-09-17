# frozen_string_literal: true

require 'spec_helper'

describe Traceindex do
  it 'has a version number' do
    expect(Traceindex::VERSION).not_to be nil
  end

  describe '#missing_index_column_names' do
    it 'missing index found.' do
      traceindex = Traceindex.new(Rails.application)
      expect(traceindex.missing_index_column_names).to eq(['users.updated_user_id'])
    end

    context 'If you have a configuration file' do
      before do
        File.open '.traceindex.yml', 'w' do |file|
          file.puts 'ignore_columns:'
          file.puts '  - users.updated_user_id'
          file.puts 'ignore_models:'
          file.puts '  - User'
        end
      end

      after do
        File.delete '.traceindex.yml'
      end

      it 'missing index not found.' do
        traceindex = Traceindex.new(Rails.application)
        expect(traceindex.missing_index_column_names).to eq([])
      end
    end
  end
end
