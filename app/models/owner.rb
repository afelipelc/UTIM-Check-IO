class Owner < ActiveRecord::Base
	has_many :devices
	validates :nombre, :clave, :pe, presence: true
	validates :clave, uniqueness: true #, message: "%{value} ya esta registrado"
end