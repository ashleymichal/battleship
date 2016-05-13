require 'rails_helper'

RSpec.describe GameSerializer, type: :serializer do
  let(:resource) { FactoryGirl.create(:game) }

  let(:serializer) { GameSerializer.new(resource) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }

  subject { JSON.parse(serialization.to_json)}

  it 'has an #id' do
    expect(subject['id']).to eql(resource.id)
  end

  describe '#board' do
    it 'returns the status only of each cell' do
      board = subject['board'].flatten
      expect(board.none? { |cell| cell['content'] }).to be_truthy
    end
  end

end
