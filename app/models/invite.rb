class Invite < ActiveRecord::Base
  belongs_to :user
  belongs_to :invited_by, :class_name => 'User', :foreign_key => 'invited_by_id'
  belongs_to :team

  validates_presence_of :user, :team, :invited_by
  validates_uniqueness_of :user_id, :scope => :team_id

  attr_writer :email, :name

  def self.not_accepted
    where(:accepted_at => nil)
  end

  def email
    return user.email if user.present?
    @email
  end

  def name_from_email
    email_name = email.split('@').first
    email_name.scan(/[a-zA-Z]+/).map(&:capitalize).join(' ')
  end

  def name
    if new_record?
      @name.blank? ? name_from_email : @name
    else
      user.name
    end
  end

  def first_name
    return name.split(' ').first if new_record?
    user.first_name
  end

  def last_name
    return name.split(' ')[1..-1].join(' ') if new_record?
    user.last_name
  end

  def accepted?
    accepted_at.present?
  end
end

# == Schema Information
#
# Table name: invites
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  team_id       :integer
#  invited_by_id :integer
#  accepted_at   :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

