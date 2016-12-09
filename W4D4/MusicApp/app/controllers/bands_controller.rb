class BandsController < ApplicationController
  before_action :require_current_user!
  before_action :require_admin!, except: [:index, :show]

  def index
    @bands = Band.all.order(:name)
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      flash[:notices] = ["#{@band.name} added!"]
      redirect_to bands_url
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def new
    @band = Band.new
  end

  def edit
    @band = Band.find_by_id(params[:id])
  end

  def show
    @band = Band.find_by_id(params[:id])
  end

  def update
    @band = Band.find_by_id(params[:id])
    if @band.update_attributes(band_params)
      flash[:notices] = ["#{@band.name} updated!"]
      redirect_to bands_url
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def destroy
    @band = Band.find_by_id(params[:id])
    if @band.nil?
      flash[:errors] = ["Band not in database"]
    else
      @band.destroy
      flash[:notices] = ["#{@band.name} deleted"]
    end

    redirect_to bands_url
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end
end
