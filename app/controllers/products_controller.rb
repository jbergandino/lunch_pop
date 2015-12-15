class ProductsController < ApplicationController
  def index
  	@product = Product.all
  end
  
  def show
    @product = Product.find(params[:id])
  end
  
  def new
  	if session[:user_id]
  	  @product = Product.new
  	else
  	  redirect_to login_path
  	end
  end

  def create
    title = params[:product][:title]
    subtitle = params[:product][:subtitle]
    description = params[:product][:description]
    price = params[:product][:price]
    expiration = params[:product][:expiration]
    counter = params[:product][:counter]


    if expiration=="true"
    	expires = DateTime.now+1.hour
    else
    	expires = DateTime.now+30.minutes
    end
    product = Product.new(title:title, subtitle:subtitle, description:description, 
    	expiration:expires, price:price, counter:counter, vendor_id: session[:user_id])

    if product.save
      flash[:alert] = "New Product Created!"
      redirect_to root_path
    else
      if product.errors.full_messages.any?
        # Reverse Array so it starts with the first error rather than last
        revErrors = product.errors.full_messages.reverse
        for i in 0..product.errors.full_messages.length-1 
          flash[:alert] = revErrors[i]
        end
      end
      redirect_to new_product_path   
    end
  end

end
