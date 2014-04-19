class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :edit, :update, :destroy]

  # GET /devices
  # GET /devices.json
  def index
      if params[:q]
        @devices = Device.includes(:owner).where("owners.nombre  LIKE '%"+params[:q]+"%'")
      else
        @devices = Device.all
      end
  end

  # GET /devices/1
  # GET /devices/1.json
  def show
    # @device = Device.find(params[:id])
    #@claveDev = @device.owner.clave + ":" + @device.id.to_s + ":" + @device.owner_id.to_s
  end

  # GET /devices/new
  def new
    @device = Device.new
    @device.owner = Owner.new
  end

  # GET /devices/1/edit
  def edit
    #@claveDev = @device.owner.clave + ":" + @device.id.to_s + ":" + @device.owner_id.to_s
  end

  # POST /devices
  # POST /devices.json
  def create
    @device = Device.new(device_params)
    @device.registro = Time.new
    @device.ultimavez = Time.new
    
    respond_to do |format|  
      savedOwner = true #false
      @device.owner = saveOwner
      # if owner
      #   @device.owner = owner
      #   savedOwner = true
      # else
      #   flash[:error] = "Ya existe un propietario con la clave: " + owner_params[:clave]
      #   format.html { render :action => 'new' } 
      # end

      if(@device.valid?)
        # if device exist, update
        if @device.save #savedOwner && 
          flash[:notice] = "Se ha registrado el Dispositivo."
          format.html { redirect_to @device }
          format.json { render :json => @device, :status => :updated, :location => @device }
        elsif @device.update_attributes(device_params) #savedOwner && 
              flash[:notice] = "El Dispositivo con clave: "+@device.id + " ha sido actualizado"
              #format.html { redirect_to @device }
              format.html { redirect_to @device }
              format.json { render :json => @device, :status => :ok }
        else
            flash[:error] =  flash[:error] + " \n Ocurrió un error al guardar los datos del Dispositivo."
            format.html { redirect_to :action => 'new' } 
        end
      else
        flash[:notice] = "No se pueden guardar los datos."
        format.html { redirect_to action: "edit" }
        format.json { render :json => @device, :status => :unprocessable_entity, :location => @device }
      end
    end
  end

  # PATCH/PUT /devices/1
  # PATCH/PUT /devices/1.json
  def update
    respond_to do |format|

      if @device.update(device_params) & Owner.update(owner_params[:id], nombre: owner_params[:nombre], clave: owner_params[:clave], pe: owner_params[:pe])
        @device = Device.find(device_params[:id])
        flash[:notice] = "Se actualizó el Dispositivo."
        format.html { redirect_to action: "edit" }
        format.json { head :no_content }
      else
        flash[:error] = @device.errors.messages.to_s
        format.html { redirect_to action: 'index' }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

def search
      if params[:id]
        if params[:id].is_number?
          redirect_to :action => "edit", :id=> params[:id]
        elsif params[:id].scan(/:/).length ==2
          datosDev = params[:id].split(":")
          #redirect_to :action => "edit", :id=> datosDev[1]
          @device = Device.validarToken(datosDev[0], datosDev[1].to_i, datosDev[2].to_i)
          if(@device)
            redirect_to @device
          else
            flash[:error] = "No se localizó el dispositivo con clave: " + params[:id]
            redirect_to action: 'index'
          end
        else
          redirect_to :action => "index", :q => params[:id]
        end
      else
        render action: 'index'
      end
  end

def printbarcode
  if params[:id]
  puts "Generando codigo de barra"
else
  flash[:error] = "Vuelva a los datos del dispositivo y presione Imprimir código."
  redirect_to :action => "index"
end
end

  # def searchItems
  #   @devices = Device.includes(:owner).where("owners.nombre  LIKE '%"+params[:q]+"%'")
  #   respond_to do |format|
  #     format.html { redirect_to @devices, notice: 'coincidencias.' }
  #     format.json { render :json => @devices, :status => :ok, :location => @devices }
  #   end
  # end

  # DELETE /devices/1
  # DELETE /devices/1.json
  # def destroy
  #   @device.destroy
  #   respond_to do |format|
  #     format.html { redirect_to devices_url }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
      @claveDev = @device.owner.clave + ":" + @device.id.to_s + ":" + @device.owner_id.to_s
      rescue ActiveRecord::RecordNotFound
        flash[:error] = "No se encontró ningún Dispositivo que contenga: " + params[:id] + ". Regístrelo aquí"
        redirect_to :action => 'new'
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_params
      params.require(:device).permit(:id, :tipo, :noserie, :marca, :color, :nota, :nombre,:clave, :pe)
    end
    def owner_params
      params.require(:owner).permit(:id, :nombre, :tipo, :clave, :pe)
    end

    def saveOwner
      owners = Owner.where(:clave => owner_params[:clave])
      if owners.blank?
        owner = Owner.new(owner_params)
        #owner.save
        return owner
      else
        owner = owners.first
        #Owner.update(owner.id, nombre: owner_params[:nombre], pe: owner_params[:pe])
        owner.nombre = owner_params[:nombre]
        owner.pe = owner_params[:pe]
        #owner = Owner.find(owner.id)
        # @device.owner = owner
        # savedOwner = true
        flash[:notice] = "Ya existe un propietario con la clave: " + owner.id.to_s + ", Se ha asociado con el dispositivo"
        return owner
      end
    end

end


class String
  def is_number?
    true if Float(self) rescue false
  end
end