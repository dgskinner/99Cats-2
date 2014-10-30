class CatsController < ApplicationController
  before_action :require_loggedin, only: [:edit, :update]  
  
  def index
    # puts "Current user: #{current_user}"
    @cats = current_user.cats
    render :index
  end
  
  def show
    @cat = Cat.find(params[:id])
    @requests = @cat.cat_rental_requests.sort_by &:start_date
    render :show
  end
  
  def create
    
    @cat = current_user.cats.new(cat_params)
    
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end
  
  def update
    
    @cat = current_user.cats.find(params[:id])
    
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  def new
    @cat = Cat.new
    render :new
  end
  
  def edit
    @cat = current_user.cats.find(params[:id])
    if @cat.nil?
      flash[:errors] ||= []
      flash[:errors] << "You don't own that cat."
      redirect_to user_cats_url
    else
      render :edit
    end
  end
  
  private
  
  def cat_params
    cat_attrs = [:birth_date, :color, :name, :sex, :description]
    params.require(:cat).permit(*cat_attrs)
  end
  
  
  
end
