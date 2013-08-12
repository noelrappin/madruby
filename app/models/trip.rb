class Trip < ActiveRecord::Base
  has_many :hotels
  has_many :activities

  validates_presence_of :description, :start_date, :end_date, :price, :tag_line

  def length_of_trip
    end_date - start_date
  end

end
