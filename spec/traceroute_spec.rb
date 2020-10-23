# frozen_string_literal: true

require 'spec_helper'

describe Traceindex do
  it 'has a version number' do
    expect(Traceindex::VERSION).not_to be nil
  end

  let(:traceindex) { Traceindex.new(Rails.application) }

  after { File.delete '.traceindex.yml' if File.exists? '.traceindex.yml' }

  describe '#missing_index_column_names' do
    it 'missing index found.' do
      expect(traceindex.missing_index_column_names).to eq(['users.updated_user_id'])
    end

    context 'If you have a configuration file(ignore_columns)' do
      before do
        File.open '.traceindex.yml', 'w' do |file|
          file.puts 'ignore_columns:'
          file.puts '  - users.updated_user_id'
        end
      end

      it 'missing index not found.' do
        expect(traceindex.missing_index_column_names).to eq([])
      end
    end

    context 'If you have a configuration file(ignore_models)' do
      before do
        File.open '.traceindex.yml', 'w' do |file|
          file.puts 'ignore_models:'
          file.puts '  - User'
        end
      end

      it 'missing index not found.' do
        expect(traceindex.missing_index_column_names).to eq([])
      end
    end

    context 'If you have a configuration file(ignore_foreign_keys)' do
      before do
        File.open '.traceindex.yml', 'w' do |file|
          file.puts 'ignore_foreign_keys:'
          file.puts '  - users.updated_user_id'
        end
      end

      it 'missing index exists.' do
        expect(traceindex.missing_index_column_names).to eq(['users.updated_user_id'])
      end
    end
  end

  describe '#missing_foreign_keys' do
    it 'missing index found.' do
      expect(traceindex.missing_foreign_keys).to eq(['users.updated_user_id'])
    end

    context 'If you have a configuration file(ignore_columns)' do
      before do
        File.open '.traceindex.yml', 'w' do |file|
          file.puts 'ignore_columns:'
          file.puts '  - users.updated_user_id'
        end
      end

      it 'missing foreign keys exists.' do
        expect(traceindex.missing_foreign_keys).to eq(['users.updated_user_id'])
      end
    end

    context 'If you have a configuration file(ignore_foreign_keys)' do
      before do
        File.open '.traceindex.yml', 'w' do |file|
          file.puts 'ignore_foreign_keys:'
          file.puts '  - users.updated_user_id'
        end
      end

      it 'missing foreign keys not found.' do
        expect(traceindex.missing_foreign_keys).to eq([])
      end
    end

    context 'If you have a configuration file(ignore_models)' do
      before do
        File.open '.traceindex.yml', 'w' do |file|
          file.puts 'ignore_models:'
          file.puts '  - User'
        end
      end

      it 'missing foreign keys not found.' do
        expect(traceindex.missing_foreign_keys).to eq([])
      end
    end
  end
end
