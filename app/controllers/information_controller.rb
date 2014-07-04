class InformationController < ApplicationController
  def index
  	redirect_to :action => "about"
  end

  def about
  end

  def reportarfallo

  end

  def procesarfallo
  	if params[:reporte]
  		flash[:notice] = "El reporte se ha registrado:\n\r" + params[:reporte]
  	else
  		flash[:notice] = "Describe el reporte."
  		redirect_to :action => "reportarfallo"
  	end
  end
end
