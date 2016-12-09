class AlbumsController < ApplicationController
  before_action :require_current_user!
  before_action :require_admin!, except: :show

  def new
    @album = Album.new
    @band_id = params[:band_id]
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      flash[:notices] = ["#{@album.title} added!"]
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def edit
    @album = Album.find_by_id(params[:id])
    @band_id = @album.band_id
  end

  def show
    @album = Album.find_by_id(params[:id])
  end

  def update
    @album = Album.find_by_id(params[:id])

    if @album.update_attributes(album_params)
      flash[:notices] = ["Album updated!"]
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    @album = Album.find_by_id(params[:id])

    if @album.nil?
      flash.now[:errors] = ["Album not in database"]
    else
      @album.destroy!
      flash[:notices] = ["Album deleted!"]
    end

    redirect_to band_url(@album.band_id)
  end

  private

  def album_params
    params.require(:album).permit(:band_id, :title, :album_type)
  end
end
