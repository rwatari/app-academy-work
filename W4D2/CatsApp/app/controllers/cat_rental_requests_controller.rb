class CatRentalRequestsController < ApplicationController
  def new
    @request = CatRentalRequest.new
    render :new
  end

  def create
    @request = CatRentalRequest.new(rental_params)
    if @request.save
      redirect_to cats_url
    else
      render :new
    end
  end

  def approve
    request = CatRentalRequest.find_by(id: params[:request_id])
    request.approve!
    redirect_to cat_url(request.cat_id)
  end

  def deny
    request = CatRentalRequest.find_by(id: params[:request_id])
    request.deny!
    redirect_to cat_url(request.cat_id)
  end

  private

  def rental_params
    params.require(:request).permit(:cat_id, :start_date, :end_date)
  end
end
