class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  # GET /entries
  # GET /entries.json
  def index
    @entry = Entry.new
    device = Device.new
    @entry.device = device
    @entry.device.owner = Owner.new
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)

    respond_to do |format|
      if @entry.save
        format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
        format.json { render action: 'show', status: :created, location: @entry }
      else
        format.html { render action: 'new' }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url }
      format.json { head :no_content }
    end
  end

def checkdevice
    #respond_to do |format|
    #check for id type: 32371298:1:1
      if params[:id]

        if(params[:id].scan(/:/).length !=2)
            flash[:error] = "Pase el código de barras del dispositivo sobre el lector."
            redirect_to :action => 'index'
        else
          datosDev = params[:id].split(":")
          hoy = Time.new
          #dispositivo con ingreso pero sin egreso
          #@entry = Entry.where(:device_id => params[:id], :ingreso => hoy.beginning_of_day..hoy.end_of_day, :egreso => nil).first
          @entry = Entry.where(:device_id => datosDev[1].to_i, :ingreso => hoy.beginning_of_day..hoy.end_of_day, :egreso => nil).first

          if @entry
            # puts @entry.device.owner_id
            # puts datosDev[2]
            if(@entry.device.owner_id != datosDev[2].to_i || @entry.device.owner.clave != datosDev[0])
              flash[:error] = "El dispositivo no pertenece al propietario. \nPase el código de barras del dispositivo sobre el lector."
              redirect_to :action => 'index'
              return
            end

              @entry.egreso = Time.new
              if(@entry.update_attribute(:egreso, Time.new))
                device = @entry.device
                device.ultimavez = Time.new
                device.update_attribute(:ultimavez, Time.new)
                flash[:notice] = "Se ha Registrado el egreso."
                redirect_to @entry
              else
                flash[:error] = "Ocurrió un error al registrar el egreso del dispositivo."
                redirect_to :action => 'index'
              end

          else
            #registrar el ingreso
            #device = Device.find(params[:id])
            device = Device.validarToken(datosDev) #datosDev[0], datosDev[1].to_i, datosDev[2].to_i) #Device.find(datosDev[1].to_i)
            if device.id>0  ## the device obtained is readonly caused by JOIN in validatToken method
              #reload device in writemode
              device = Device.find(device.id)
                # if(device.owner_id != datosDev[2].to_i || device.owner.clave != datosDev[0])
                #   flash[:error] = "El dispositivo no pertenece al propietario. \nPase el código de barras del dispositivo sobre el lector."
                #   redirect_to :action => 'index'
                #   return
                # end
                @entry = Entry.new
                @entry.ingreso = Time.new
                @entry.device = device
                if(@entry.save)
                  device.update_attribute(:ultimavez, Time.new)
                  flash[:notice] = "Se ha Registrado el ingreso."
                  redirect_to @entry
                else
                  flash[:error] = "Ocurrió un error al intentar registrar el Ingreso."
                  redirect_to :action => 'index'
                end  
            else
                flash[:error] = "El dispositivo no pertenece al propietario. \nPase el código de barras del dispositivo sobre el lector."
                redirect_to :action => 'index'
            end
          end
        end
      else
        flash[:error] = "Proporcionar el Código de dispositivo."
        redirect_to :action => 'index'
      end
    #end

    rescue ActiveRecord::RecordNotFound
            flash[:error] = "No se encontró el Dispositivo"
            redirect_to :action => 'index'
  end

def logs
  if params[:date]
    fecha = Date.strptime(params[:date], "%d/%m/%Y")
    @entries = Entry.where(:ingreso => fecha.beginning_of_day..fecha.end_of_day).order(ingreso: :desc)
  else  
    hoy = Time.new
    if params[:id]
       @entries = Entry.where(:device_id => params[:id]).order(ingreso: :desc)
       if @entries.blank?
         @entries = Entry.where(:ingreso => hoy.beginning_of_day..hoy.end_of_day)
         flash[:error] = "No se encontraron registros de este Dispositivo " + params[:id]
       end
    else
      @entries = Entry.where(:ingreso => hoy.beginning_of_day..hoy.end_of_day).order(ingreso: :desc)
      params[:date] = Time.new.strftime("%d/%m/%Y")
    end
  end
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = "No se encontró el registro: " + params[:id]
        redirect_to :action => 'index'
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:ingreso, :egreso, :id)
    end
end
