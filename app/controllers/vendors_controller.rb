class VendorsController < ApplicationController
  def show
    @thisProducts = Myproduct.where(vendor_id:session[:user_id])
    @thisUser = User.find(session[:user_id]).username
    @now = DateTime.now
  end

  def new
    if session[:user_id]
      redirect_to '/home'
    end
    @vendor = Vendor.new
  end
  def create
    bname = params[:vendor][:bname]
    contact = params[:vendor][:contact]
    address = params[:vendor][:address]
    city = params[:vendor][:city]
    zip = params[:vendor][:zip]
    username = params[:vendor][:username]
    phone = params[:vendor][:phone]
    email = params[:vendor][:email]
    password = params[:vendor][:password]
    password_confirmation = params[:vendor][:password_confirmation]
    vend = true

    vendor = Vendor.new(bname:bname, contact:contact, address:address, city:city, zip:zip, username:username, email:email,
      password:password,password_confirmation:password_confirmation, phone:phone, vend:vend)
    
    if vendor.save
      # create a placeholder username in users table so users and vendors cannot share usernames
      randNum = rand(0..999999).to_s
      userPlaceholder = "placehold#{randNum}"
      emailPlaceholder = "#{userPlaceholder}@aol.com"
      User.create(fname:"placeholdfname", lname:"placeholdlname", username:username, email:emailPlaceholder, 
      password:userPlaceholder,password_confirmation:userPlaceholder, phone:"111-111-1111", vend:"false") 
      flash[:alert] = "New Vendor Account Created, Please Login"
      redirect_to mylogin_path
    else
      if vendor.errors.full_messages.any?
        # vendor.errors.full_messages.each do |message| 
        #   flash[:alert] = vendor.errors.full_messages
        # end
        
        # Reverse Array so it starts with the first error rather than last
        revErrors = vendor.errors.full_messages.reverse
        for i in 0..vendor.errors.full_messages.length-1 
          flash[:alert] = revErrors[i]
        end
        #flash[:alert] = vendor.errors.full_messages.join(', ')
      end
      redirect_to new_vendor_path   
    end
  end

  def edit
    @vendor = Vendor.find(session[:user_id])
  end
  def update
    @vendor = Vendor.find(session[:user_id])
    user = User.find(session[:user_id])
    @vendor.update(params.require(:vendor).permit(:username, :email, :password, :password_confirmation))
    username = params[:vendor][:username]
    email = params[:vendor][:email]
    user.update(username: username, email: email)
    flash[:notice] = "vendor Successfully Updated"
    redirect_to vendor_path(@vendor)
  end

  def destroy
    @vendor = Vendor.find(session[:user_id])
    user = User.find(session[:user_id])
    username = @vendor.username
    newUsername="#{username}DELETEDzz"
    @vendor.update(username:newUsername)
    user.update(username:newUsername)
    #user = User.find(session[:user_id])
    # if user.fname == "placeholdfname"
    #   user.delete
    #   @vendor.delete
    # end
    session[:user_id] = nil
    flash[:notice] = 'Vendor Deleted!'
    redirect_to '/home'
  end
end