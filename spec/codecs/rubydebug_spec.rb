require "logstash/devutils/rspec/spec_helper"
require "logstash/codecs/rubydebug"
require "logstash/event"

describe LogStash::Codecs::RubyDebug do

  subject { LogStash::Codecs::RubyDebug.new }

  context "#encode" do
    let(:event) { LogStash::Event.new({"what" => "ok", "who" => 2}) }

    before(:each) { subject.register }

    it "should print beautiful hashes" do
      on_event = lambda { |e, d| expect(d.chomp).to eq(event.to_hash.ai) }

      subject.on_event(&on_event)
      expect(on_event).to receive(:call).once.and_call_original

      subject.encode(event)
    end
  end

  context "#decode" do
    it "should not be implemented" do
      expect { subject.decode("data") }.to raise_error("Not implemented")
    end
  end
end
