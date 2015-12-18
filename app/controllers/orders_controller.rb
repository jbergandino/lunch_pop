class OrdersController < ApplicationController
  def show
  	# make it so you can add to cart even if you aren't logged in
  	#if session[:user_id]
  	  
  	@order = Order.where(id:session[:user_id])
  	#end
  end

  def new
  	@order = Order.new
  	#cookies[:cart_product] = Myproduct.find(params[:id])
  end

  def create
    id = session[:user_id]
    product = Myproduct.find(params[:id])
    thisProductExpiration = Myproduct.where(id:product).first.expiration
    thisProductCounter = Myproduct.where(id:product).first.counter
    
    # if order is not expired && there are products available, then allow it to be saved
    # if thisProductExpiration > DateTime.now && thisProductCounter > 0

    order = Order.new(user_id:id, product_id:product)
      # Charge credit card with before_save hook

    if order.save
      #flash[:alert] = "Order Submitted!"
      flash[:alert] = "Added To Cart"
      redirect_to '/home'
    else
      if order.errors.full_messages.any?
        # Reverse Array so it starts with the first error rather than last
        revErrors = order.errors.full_messages.reverse
        for i in 0..order.errors.full_messages.length-1 
          flash[:alert] = revErrors[i]
        end
      end
      redirect_to '/home'   
    end
  end

end
