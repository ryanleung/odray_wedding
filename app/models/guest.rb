class Guest < ActiveRecord::Base
	has_many :plus_ones
end
