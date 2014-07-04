class Owner < ActiveRecord::Base
	has_many :devices
	validates :nombre, :clave, :pe, presence: true
	validates :clave, uniqueness: true #, message: "%{value} ya esta registrado"

	def hasPicture
		File.exists?("public/userpics/" + self.id.to_s+".jpg")
	end
end