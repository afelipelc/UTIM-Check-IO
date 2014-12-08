class AdminsController < ApplicationController
	before_action :authenticate_user!
	load_and_authorize_resource
	before_action :set_user, only: [:show, :edit, :update, :destroy]


	def index
		@users = User.all	
	end

	def show
		flash[:info] = 'No existe una vista de usuario, utilice Editar'
		redirect_to :action => 'index'
	end

	def new
		@user = User.new
	end

	def create
	  @user = User.new(user_params)
      respond_to do |format|
      	if(User.first.nil?)
          @employee.role = 1
        end
	      if @user.save
	        format.html { redirect_to :action => 'index', notice: 'El usuario ha sido registrado.' }
	        format.json { render :show, status: :created, notice: 'El usuario ha sido registrado.' }
	      else
	        format.html { render :new, error: 'Ocurrió un error al intentar registrar el usuario.' }
	        format.json { render json: @user.errors, status: :unprocessable_entity }
	      end
      end
	end

	def edit
	end

	def update
		respond_to do |format|
		  if @user.update(user_params)
		    format.html { redirect_to admins_url, sucess: 'El usuario ' + @user.nombre + ' ha sido actualizado.' }
		    format.json { render :show, status: :ok, location: @user }
		  else
		    format.html { render :edit }
		    format.json { render json: @user.errors, status: :unprocessable_entity }
		  end
		end
	end

  private
	def set_user
      @user = User.find(params[:id])
    end
    def user_params
      params.require(:user).permit(:username, :nombre, :role, :activo, :email, :password, :password_confirmation)
    end
end
