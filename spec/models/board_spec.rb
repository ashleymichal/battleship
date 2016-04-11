require 'rails_helper'

RSpec.describe Board do

  describe "#initialize" do
    subject { Board.new }

    it "initializes a 10 x 10 grid by default" do
      expect(subject.grid).to have(10).things
      subject.grid.each do |row|
        expect(row).to have(10).things
      end
    end

  end

end