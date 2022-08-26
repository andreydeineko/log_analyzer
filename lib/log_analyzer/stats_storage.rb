require "set"

module LogAnalyzer
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

    # we could be smarter here and strip the sub path of the webpage path, so
    # that /about/2 and /about are considered same, but would depend on business
    # requirements.
    def add(endpoint, ip)
      data[endpoint][:count] += 1
      data[endpoint][:unique_ips] << ip
    end

    private

    attr_writer(:data)
  end
end
