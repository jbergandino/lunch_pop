class MyproductsController < ApplicationController

  def index
  	@product = Myproduct.all
  end
  
  def show
    @product = Myproduct.find(params[:id])
    @expiration = @product.expiration
  end
  
  def new
  	if session[:user_id]
  	  @product = Myproduct.new
  	else
  	  redirect_to mylogin_path
  	end
  end

  def create
    title = params[:myproduct][:title]
    subtitle = params[:myproduct][:subtitle]
    description = params[:myproduct][:description]
    price = params[:myproduct][:price]
    expiration = params[:myproduct][:expiration]
    counter = params[:myproduct][:counter]


    if expiration=="true"
    	expires = DateTime.now+1.hour
    else
    	expires = DateTime.now+30.minutes
    end
    product = Myproduct.new(title:title, subtitle:subtitle, description:description, 
    	expiration:expires, price:price, counter:counter, vendor_id: session[:user_id])

    if product.save
      flash[:alert] = "New Product Created!"
      redirect_to '/home'
    else
      if product.errors.full_messages.any?
        # Reverse Array so it starts with the first error rather than last
        revErrors = product.errors.full_messages.reverse
        for i in 0..product.errors.full_messages.length-1 
          flash[:alert] = revErrors[i]
        end
      end
      redirect_to new_myproduct_path   
    end
  end

end
