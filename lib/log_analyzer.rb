#!/usr/bin/env ruby

require_relative "log_analyzer/options_validator"
require_relative "log_analyzer/file_reader"
require_relative "log_analyzer/stats_storage"
require_relative "log_analyzer/stats_printer"

module LogAnalyzer
  class << self
    LOG_LINE_SEPARATOR = " ".freeze

    def call
      filename = OptionsValidator.new(ARGV).call
      stats_storage = StatsStorage.new

      FileReader.call(filename) do |line|
        stats_storage.add(*line.split(LOG_LINE_SEPARATOR))
      end

      StatsPrinter.call(stats_storage.data)
    end
  end
end

LogAnalyzer.call
