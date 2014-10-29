class CatRentalRequestsController < ApplicationController
  
  def create
    @request = CatRentalRequest.new(rental_params)
   
    if @request.save
      redirect_to cat_url(@request.cat)
    else
      flash.now[:errors] = @request.errors.full_messages
      @cats = Cat.all
      render :new
    end
  end
  
  def approve
    @request = CatRentalRequest.includes(:cat).find(params[:id])
    
    flash.now[:errors] = @request.errors.full_messages unless @request.approve!
    
    redirect_to cat_url(@request.cat)   
  end
  
  def deny
    @request = CatRentalRequest.includes(:cat).find(params[:id])  
    
    flash.now[:errors] = @request.errors.full_messages unless @request.deny!

    redirect_to cat_url(@request.cat)   
  end
  
  def new
    @cats = Cat.all
    @request = CatRentalRequest.new
    render :new
  end
  
  private
  
  def rental_params
    rental_attrs = [:cat_id, :start_date, :end_date, :status]
    params.require(:cat_rental_request).permit(*rental_attrs)
  end
end
