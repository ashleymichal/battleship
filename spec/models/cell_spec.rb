require 'rails_helper'

RSpec.describe Cell do
  describe "#fire!" do
    subject { Cell.new }

    context "has not been fired upon" do

      context "is occupied" do
        before do
          subject.contents ||= Ship.build(Ship::BOAT_TYPE).id
          subject.fire!
        end

        it "changes the cell's status to :hit" do
          expect(subject.status).to eql(:hit)
        end

        it "hits the ship object" do
          expect(Ship.find(subject.contents).hits).to eql(1)
        end
      end

      context "is unoccupied" do
        before do
          subject.fire!
        end

        it "changes status to :miss" do
          expect(subject.status).to eql(:miss)
        end
      end

    end

    context "has already been fired upon" do
      it "raises an exception when already been fired upon" do
        subject.fire!
        expect{ subject.fire! }.to raise_error(AlreadyHitError)
      end
    end

  end
end