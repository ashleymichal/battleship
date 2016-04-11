require 'rails_helper'

RSpec.describe Cell do
  subject { Cell.new }

  describe "#hit!" do

    context "when a ship is present" do
      before do
        subject.ship = :ship
      end

      it "changes status to :hit" do
        expect { subject.hit! }.to change(subject, :status).to(:hit)
      end

      it "returns :hit" do
        expect(subject.hit!).to eql(:hit)
      end
    end

    context "when empty" do
      it "changes status to :miss" do
        expect { subject.hit! }.to change(subject, :status).to(:miss)
      end

      it "returns :miss" do
        expect(subject.hit!).to eql(:miss)
      end
    end

    context "when already fired upon" do
      it "raises an error" do
        subject.status = :hit
        expect{ subject.hit! }.to raise_error(AlreadyHitError)
      end
    end

  end

end