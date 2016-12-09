class TracksController < ApplicationController
  before_action :require_current_user!
  before_action :require_admin!, except: :show

  def new
    @track = Track.new
    @album_id = params[:album_id]
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      flash[:notices] = ["#{@track.title} added!"]
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def edit
    @track = Track.find_by_id(params[:id])
    @album_id = @track.album_id
  end

  def show
    @track = Track.find_by_id(params[:id])
    @notes = @track.notes.includes(:user)
  end

  def update
    @track = Track.find_by_id(params[:id])

    if @track.update_attributes(track_params)
      flash[:notices] = ["Track updated!"]
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def destroy
    @track = Track.find_by_id(params[:id])

    if @track.nil?
      flash[:errors] = ["Track not in database"]
    else
      @track.destroy!
      flash[:notices] = ["Track deleted!"]
    end

    redirect_to album_url(@track.album_id)
  end

  private

  def track_params
    params.require(:track).permit(:album_id, :name, :track_type, :lyrics)
  end
end
