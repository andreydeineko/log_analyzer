require "./stats_printer"
require "./stats_storage"
require "./file_reader"

describe StatsPrinter do
  describe ".call" do
    let(:storage) { StatsStorage.new }

    before do
      FileReader.call("./spec/fixtures/webserver.log") do |line|
        storage.add(*line.split(" "))
      end
    end

    it "outputs the sorted stats" do
      expect { described_class.call(storage.data) }.to(
        output(
          include(
            "Sorted by views count",
            "/help_page/1 - 5 views",
            "/home - 2 views",
            "/contact - 2 views",
            "/about - 1 views",
            "/index - 1 views",
            "/about/2 - 1 views",
            "=======================",
            "Sorted by unique views count",
            "/help_page/1 - 5 unique views",
            "/home - 2 unique views",
            "/about - 1 unique views",
            "/index - 1 unique views",
            "/about/2 - 1 unique views",
            "/contact - 1 unique views"
          )
        ).to_stdout
      )
    end
  end
end
