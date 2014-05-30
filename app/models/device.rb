class Device < ActiveRecord::Base
	belongs_to :owner, :autosave => true
	has_many :entrys

	def self.validarToken(params)#ownerClave, idDevice, idOwner)
    if params#ownerClave && idOwner && idDevice
      joins(:owner).where('owner_id = ? and devices.id = ? and clave = ?', params[1],params[2],params[0]).first #idOwner, idDevice).first

#puts "Datos Dispos>>>>" + self.owner_id

      #where('id = ?', idDevice).includes(:owner).where("clave = ?", ownerClave).references(:owner).first
      #.first #  LIKE ? or descripcion like ?', "%#{buscar}%","%#{buscar}%")
			#find(idDevice, :conditions => { :owner => {:id => idOwner, :clave => ownerClave}})
    else
      nil
    end
  end

  def devicetoken
    owner.clave+":"+id.to_s+":"+owner_id.to_s
  end
end
