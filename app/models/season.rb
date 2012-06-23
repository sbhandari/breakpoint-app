class Season < ActiveRecord::Base
  include ChronicParser

  has_many :practices
  has_many :players
  has_many :users, :through => :players
  
  attr_accessible :name

  validates_presence_of :name

  def self.newest
    order('date desc')
  end
end
