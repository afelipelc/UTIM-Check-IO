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
  end

  # GET /devices/new
  def new
    @device = Device.new
    @device.owner = Owner.new
  end

  # GET /devices/1/edit
  def edit
  end

  # POST /devices
  # POST /devices.json
  def create
    #@device = Device.new(params.require(:device).permit(:id, :tipo, :noserie, :marca, :color, :nota))
    @device = Device.new(device_params)
    @device.registro = Time.new
    @device.ultimavez = Time.new
    #@owner = Owner.new(params.require(:owner).permit(:id, :nombre, :tipo, :clave, :pe))
    @owner = Owner.new(owner_params)
    @device.owner = @owner
    
    # if owner exist, update
    if @owner.save
      @device.owner = @owner
    elsif   @owner.update_attributes(params.require(:owner).permit(:id, :nombre, :tipo, :clave, :pe))
      @device.owner = @owner
    end

    respond_to do |format|
      # if device exist, update
      if @device.save
        #format.html { redirect_to @device, :notice => 'El nuevo Dispositivo ha sido registrado correctamente.' }
        flash[:notice] = "Se ha registrado el Dispositivo."
        format.html { render action: 'edit' }
        format.js   {}
        format.json { render :json => @device, :status => :updated, :location => @device }
      elsif @device.update_attributes(params[:device])    
            flash[:notice] = "El Dispositivo con clave: "+@device.id + " ha sido actualizado"
            #format.html { redirect_to @device }
            format.html { render action: 'edit' }
            format.js   {}
            format.json { render :json => @device, :status => :ok }
      else
          flash[:error] = "Ocurrió un error al guardar los datos del Dispositivo."
          redirect_to :action => 'new'
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
        format.html { redirect_to action: 'index' }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

def search
    #respond_to do |format|
      if params[:id]
        #@dispositivos = nil
        if params[:id].is_number?
          redirect_to :action => "edit", :id=> params[:id]
          #redirect_to :action => "show", :id=> params[:q]
          # @device = Device.find(params[:id])
          # if(@device)
          #   format.html { render :action => "edit"}
          #   #format.html { redirect_to :action => "show", :id => params[:q] }
          #   format.js   {}
          #   format.json { render :json => @device, :status => :ok, :location => @device }
          # else
          #   format.html { render action: 'new' }
          #   format.json { render json: @device.errors, status: :unprocessable_entity }
          # end
        else
          #@devices = Device.includes(:owner).where("owners.nombre  LIKE '%"+params[:id]+"%'")
          # if @devices
          redirect_to :action => "index", :q => params[:id]
           #format.html { render @devices}
          #   # format.js   {}
          #   # format.json { render :json => @devices, :status => :ok, :location => @devices }
          # else
          #   format.html { render action: 'index' }
          #   format.json { render json: @devices.errors, status: :unprocessable_entity }
          # end
        end
        
        # flash[:error] = "No se encontró ninguna coincidencia con: " + params[:q]
        # format.html { redirect_to :action => 'index' }

      
      else
        render action: 'index'
        # format.html { render action: 'index' }
        # format.json { render json: @devices.errors, status: :unprocessable_entity }
      end
    #end
    # rescue ActiveRecord::RecordNotFound
    #         flash[:error] = "No se encontró ningún Dispositivo que contenga: " + params[:q]
    #         redirect_to :action => 'new'
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
end


class String
  def is_number?
    true if Float(self) rescue false
  end
end