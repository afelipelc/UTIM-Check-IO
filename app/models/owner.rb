class Owner < ActiveRecord::Base
	has_many :devices
	validates :nombre, :clave, :pe, presence: true
	#validates :clave, :uniqueness => true
end