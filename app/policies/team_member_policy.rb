class TeamMemberPolicy < ApplicationPolicy
  def update?
    owner? || captain?
  end

  private

  def owner?
    user.id == record.user_id
  end

  def captain?
    member = user.team_members.where(:team_id => record.team_id).first
    return false if member.nil?
    member.captain?
  end
end

