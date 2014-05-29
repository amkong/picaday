class Challenge < ActiveRecord::Base
  has_many :images

  def self.yesterday
    yesterday = 1.day.ago
    where(date: (yesterday.beginning_of_day..yesterday.end_of_day)).take
  end

  def self.today
    # where( date: (Time.now.beginning_of_day..Time.now.end_of_day)).take
    # where( date: (Time.now.beginning_of_day..Time.now.end_of_day)).take
    find_by(date: Date.today.to_s)
  end
end