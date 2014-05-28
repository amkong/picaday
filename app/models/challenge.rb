class Challenge < ActiveRecord::Base
  has_many :images

  def self.yesterday
    yesterday = 1.day.ago
    where(date: (yesterday.beginning_of_day..yesterday.end_of_day)).take(1)
  end

  def self.today
    where( date: (Time.now.beginning_of_day..Time.now.end_of_day)).take(1)
  end
end