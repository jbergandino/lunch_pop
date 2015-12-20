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
    dealsSold = 0

    uniqueIdentifier = session[:user_id].to_s << title.to_s << rand(0..999999).to_s
    uniqueIdentifier = uniqueIdentifier.gsub(/[^a-zA-Z0-9]/,'')


    if expiration=="true"
    	expires = DateTime.now+1.hour
    else
    	expires = DateTime.now+30.minutes
    end
    product = Myproduct.new(title:title, subtitle:subtitle, description:description, 
    	expiration:expires, price:price, counter:counter, deals_began_with:counter, deals_sold:dealsSold, 
      vendor_id:session[:user_id], unique_identifier:uniqueIdentifier)

    spreeproduct = Spree::Product.new(name:title, price:price, description:description, 
      shipping_category_id:1, available_on:'2015-12-10 00:00:00', expiration:expires, counter:counter, deals_began_with:counter, 
      deals_sold:dealsSold, vendor_id:session[:user_id], unique_identifier:uniqueIdentifier)


    if product.save && spreeproduct.save
      flash[:alert] = "New Product Created!"
      redirect_to '/mydeals'
    else
      if product.errors.full_messages.any?
        # Reverse Array so it starts with the first error rather than last
        revErrors = product.errors.full_messages.reverse
        spreeErrors = spreeproduct.errors.full_messages.reverse
        if product.errors
          for i in 0..product.errors.full_messages.length-1 
            flash[:alert] = revErrors[i]
          end
        end
        if spreeproduct.errors
          for i in 0..spreeproduct.errors.full_messages.length-1 
            flash[:alert] = spreeErrors[i]
          end
        end
      end
      redirect_to new_myproduct_path   
    end
  end

  def edit
    @product = Myproduct.find(params[:id])
  end
  def update
    @product = Myproduct.find(params[:id])
    counter = @product.counter
    dealsSold = @product.deals_sold
    if counter > 0
      newCounter = counter - 1
      newDealsSold = dealsSold + 1
    else
      newCounter = 0
      newDealsSold = dealsSold
    end

    @spreeProduct = Spree::Product.find(params[:id])
    spreeCounter = @spreeProduct.counter
    spreeDealsSold = @spreeProduct.deals_sold
    if spreeCounter > 0
      newSpreeCounter = spreeCounter - 1
      newSpreeDealsSold = spreeDealsSold + 1
    else
      newSpreeCounter = 0
      newSpreeDealsSold = spreeDealsSold
    end

    @spreeProduct.update(counter:newSpreeCounter, deals_sold:newSpreeDealsSold)
    @product.update(counter:newCounter, deals_sold:newDealsSold)

    #WebsocketRails[:channel_updates].trigger 'boopcast', 'thisWorked'
    #flash[:notice] = "Product Successfully Updated"
    redirect_to myproduct_path(@product)
  end

  def socket
    WebsocketRails[:channel_updates].trigger 'new_person', 'first socket'
  end

  def secondsocket
    WebsocketRails[:channel_updates].trigger 'boopcast', 'second socket'
  end


end







