class Product < ActiveRecord::Base
	validates :title, :description, :image_url, presence: true
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	validates :title, uniqueness: true
	validates :image_url, allow_blank: true, format: {
		with: %r{\.(gif|jpg|png)\z}i,
		message: 'It is wrong.' 
	}
	validates :title, length: {minimum: 10, too_short: 'please enter at least 10 characters'}
end
