# == Schema Information
#
# Table name: games
#
#  id          :integer          not null, primary key
#  creator     :integer
#  participant :integer
#  status      :string(255)      default("new")
#  winner      :integer
#  whose_turn  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Game do
  before { @game = Game.new(creator:1)}

  subject {@game}

  it {should respond_to(:creator)}
  it {should respond_to(:participant)}
  it {should respond_to(:status)}
  it {should respond_to(:winner)}
  it {should respond_to(:whose_turn)}
  it {should be_valid}

  context "when creator is not present" do
    before {@game.creator=nil}
    it {should_not be_valid}
  end

  context "when status is not present" do
    before {@game.status=""}
    it {should_not be_valid}
  end
  
  context "when status is not valid" do
    before {@game.status="in progress"}
    it {should_not be_valid}
  end

  context "when status is valid" do
    it "should be valid" do
      statuses = %w[new, active, closed]
      statuses.each do |s|
        @game.status = s
        @game.should be_valid
      end
    end
  end
end
