require "./stats_storage"

describe StatsStorage do
  describe "#add" do
    let(:storage) { described_class.new }

    example do
      storage.add("foo", "123")

      expect(storage).to(
        have_attributes(
          data: match(
            "foo" => {
              count: 1,
              unique_ips: include("123")
            }
          )
        )
      )

      storage.add("foo", "123")

      expect(storage).to(
        have_attributes(
          data: match(
            "foo" => {
              count: 2,
              unique_ips: include("123")
            }
          )
        )
      )

      storage.add("bar", "123")

      expect(storage).to(
        have_attributes(
          data: match(
            "foo" => {
              count: 2,
              unique_ips: include("123")
            },
            "bar" => {
              count: 1,
              unique_ips: include("123")
            }
          )
        )
      )

      storage.add("bar", "1234")

      expect(storage).to(
        have_attributes(
          data: match(
            "foo" => {
              count: 2,
              unique_ips: include("123")
            },
            "bar" => {
              count: 2,
              unique_ips: include("123", "1234")
            }
          )
        )
      )
    end
  end
end
