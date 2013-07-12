class Trip < ActiveRecord::Base
  has_many :hotels
  has_many :activities

  validates_presence_of :description, :start_date, :end_date, :price, :tag_line

end
