#!/usr/bin/env ruby

require "./options_validator"
require "./file_reader"
require "./stats_storage"
require "./stats_printer"

LOG_LINE_SEPARATOR = " ".freeze

filename = OptionsValidator.new(ARGV).call
stats_storage = StatsStorage.new

FileReader.call(filename) do |line|
  stats_storage.add(*line.split(LOG_LINE_SEPARATOR))
end

StatsPrinter.call(stats_storage.data)
