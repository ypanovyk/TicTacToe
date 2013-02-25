# == Schema Information
#
# Table name: games
#
#  id          :integer          not null, primary key
#  creator     :integer
#  participant :integer
#  status      :string(255)
#  winner      :integer
#  whose_turn  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Game < ActiveRecord::Base
  attr_accessible :creator, :participant, :status, :whose_turn, :winner
  VALID_STATUS_REGEX = /new|active|closed/

  validates :creator, presence: true
  validates :status, presence: true, format: {with: VALID_STATUS_REGEX}
end
