module StatsPrinter
  extend self

  def call(log_storage_data)
    puts "Sorted by views count"
    log_storage_data
      .sort_by { |endpoint, stats| stats[:count] }
      .reverse_each { |endpoint, stats| puts("#{endpoint} - #{stats[:count]} views") }

    puts "======================="

    puts "Sorted by unique views count"
    log_storage_data
      .sort_by { |endpoint, stats| stats[:unique_ips].size }
      .reverse_each { |endpoint, stats| puts("#{endpoint} - #{stats[:unique_ips].size} unique views") }
  end
end
