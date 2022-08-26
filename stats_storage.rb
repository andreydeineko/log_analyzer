require "set"

class StatsStorage
  attr_reader(:data)

  def initialize
    @data = Hash.new do |hash, key|
      hash[key] = {
        count: 0,
        unique_ips: Set.new
      }
    end
  end

  def add(endpoint, ip)
    data[endpoint][:count] += 1
    data[endpoint][:unique_ips] << ip
  end

  private

  attr_writer(:data)
end
