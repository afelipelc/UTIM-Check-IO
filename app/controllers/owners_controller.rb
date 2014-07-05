class OwnersController < ApplicationController
  before_action :set_owner, only: [:show, :edit, :update, :destroy]

  # GET /owners
  # GET /owners.json
  def index
    #@owners = Owner.all
    if params[:q]
      @owners = Owner.where("nombre LIKE '%"+params[:q]+"%' or clave LIKE '%"+params[:q]+"%'")
    end

  end

  def find
    respond_to do |format|
      if params[:clave]
        @owner = Owner.where(:clave => params[:clave]).first
        if @owner
          format.html { redirect_to @owner }
          format.json { render json: @owner, status: :ok}
        else
          @owner = Owner.new
          format.html { redirect_to @owner }
          format.json { render json: @owner, status: :unprocessable_entity}
        end
      else
        @owner = Owner.new
        format.html { redirect_to @owner }
        format.json { render json: @owner, status: :unprocessable_entity}
      end
    end
  end
  # GET /owners/1
  # GET /owners/1.json
  def show
    #puts "Dispositivos prop: " + @owner.devices.count.to_s
  end

  # GET /owners/new
  def new
    redirect_to :owners #no permit
  end

  # GET /owners/1/edit
  def edit 
    redirect_to :owners #no permit
  end

  # POST /owners
  # POST /owners.json
  def create
    @owner = Owner.new(owner_params)

    respond_to do |format|
      if @owner.save
        format.html { redirect_to @owner, notice: 'Owner was successfully created.' }
        format.json { render action: 'show', status: :created, location: @owner }
      else
        format.html { render action: 'new' }
        format.json { render json: @owner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /owners/1
  # PATCH/PUT /owners/1.json
  def update
    redirect_to :owners #no permit
  end

  # DELETE /owners/1
  # DELETE /owners/1.json
  def destroy
    redirect_to :owners #no permit
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_owner
      @owner = Owner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def owner_params
      params.require(:owner).permit(:nombre, :tipo, :clave, :pe)
    end
end
