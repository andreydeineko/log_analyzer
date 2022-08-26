require "./options_validator"

describe OptionsValidator do
  describe ".call" do
    subject { described_class.new(args).call }

    context "when number of arguments is unexpected" do
      let(:args) { ["too", "many"] }

      it "raises an exception" do
        expect { subject }.to(
          raise_error("Expected 1 argument, received #{args.size} arguments")
        )
      end
    end

    context "when file extension is unexpected" do
      let(:args) { ["logfile.foo"] }

      it "raises an exception" do
        expect { subject }.to(
          raise_error(/Expected file with .log extension, received .foo/)
        )
      end
    end

    context "when file does not exist" do
      let(:args) { ["logfile.log"] }

      it "raises an exception" do
        expect { subject }.to(
          raise_error(/logfile.log/)
        )
      end
    end

    context "happy path" do
      let(:args) { ["./spec/fixtures/webserver.log"] }

      it "returns filename" do
        expect(subject).to eq(args.first)
      end
    end
  end
end
