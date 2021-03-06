class Practice < ActiveRecord::Base
  include DateTimeParser
  include NotifyStateMachine

  has_many   :practice_sessions, :dependent => :destroy
  has_many   :players,           :through   => :practice_sessions, :source => :user

  validates :team, presence: true

  acts_as_tenant :team
  has_paper_trail :ignore => [:notified_state, :updated_at]

  def practice_session_for(user_id)
    practice_sessions.where(user_id: user_id).first || practice_sessions.build(user_id: user_id)
  end

  def available_players
    practice_sessions.includes(:user).where(:available => true).collect(&:user)
  end

  def recent_changes
    versions.last.changeset
  end
end

# == Schema Information
#
# Table name: practices
#
#  id             :integer          not null, primary key
#  date           :datetime         not null
#  comment        :text
#  team_id        :integer          default(0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  notified_state :string(255)
#  location       :text
#

