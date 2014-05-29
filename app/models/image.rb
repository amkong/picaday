class Image < ActiveRecord::Base
  belongs_to :challenge

  validates :url, presence: true
  validate :valid_uri

  def valid_uri
    errors.add(:url, "wasn't quite right. Maybe you typed it wrong, you big dork!") unless 
      self.url =~ /\A#{URI::DEFAULT_PARSER.regexp[:ABS_URI]}\z/ || url.blank?
  end
end