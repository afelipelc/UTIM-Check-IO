class Device < ActiveRecord::Base
	belongs_to :owner, :autosave => true
	has_many :entrys
end
