require 'spec_helper'

describe KafkaRest::Producer do
  let(:klass) { JsonProducer1 }

  context 'attrs' do
    subject { klass }

    it 'has topic' do
      expect(subject.get_topic).to eq :test_topic
    end

    it 'has format' do
      expect(subject.get_format).to eq :json
    end

    it 'has_key fn' do
      expect(subject.get_key).to eq :get_key
    end

    it 'sends a message' do
      obj = "test"
      msg = KafkaRest::Producer::Message.new(klass, obj)

      expect(JsonProducer1)
        .to receive(:build_message).and_return(msg)

      expect(KafkaRest::Sender::KafkaSender.instance)
        .to receive(:send!).with(msg)

      klass.send!(obj)
    end
  end
end
