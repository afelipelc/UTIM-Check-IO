class Device < ActiveRecord::Base
	belongs_to :owner, :autosave => true
	has_many :entrys

	def self.validarToken(ownerClave, idDevice, idOwner)
    if ownerClave && idOwner && idDevice
      where('owner_id = ? and id = ?', idOwner, idDevice).first
      #where('id = ?', idDevice).includes(:owner).where("clave = ?", ownerClave).references(:owner).first
      #.first #  LIKE ? or descripcion like ?', "%#{buscar}%","%#{buscar}%")
			#find(idDevice, :conditions => { :owner => {:id => idOwner, :clave => ownerClave}})
    else
      scoped
    end
  end
end
