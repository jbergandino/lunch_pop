class UsersController < ApplicationController
  def show
  end

  def new
    if session[:user_id]
      redirect_to '/home'
    end
    @user = User.new
  end
  
  def create
    fname = params[:user][:fname]
    lname = params[:user][:lname]
    username = params[:user][:username]
    phone = params[:user][:phone]
    email = params[:user][:email]
    password = params[:user][:password]
    password_confirmation = params[:user][:password_confirmation]
    vend = false

    user = User.new(fname:fname, lname:lname, username:username, email:email,
      password:password,password_confirmation:password_confirmation, phone:phone, vend:vend)

    if user.save
      # create a placeholder username in vendors table so users and vendors cannot share usernames
      randNum = rand(0..999999).to_s
      userPlaceholder = "placehold#{randNum}"
      emailPlaceholder = "#{userPlaceholder}@aol.com"
      Vendor.create(bname:userPlaceholder, contact:"placeholdcname", address:"placeholdaddress", city:"placeholdcity", 
      zip:"placeholdzip", username:username, email:emailPlaceholder, password:userPlaceholder,password_confirmation:userPlaceholder, 
      phone:"111-111-1111", vend:"true") 
      flash[:alert] = "New User Created, Please Login"
      redirect_to mylogin_path
    else
      if user.errors.full_messages.any?
        # user.errors.full_messages.each do |message| 
        #   flash[:alert] = user.errors.full_messages
        # end

        # Reverse Array so it starts with the first error rather than last
        revErrors = user.errors.full_messages.reverse
        for i in 0..user.errors.full_messages.length-1 
          flash[:alert] = revErrors[i]
        end
        #flash[:alert] = user.errors.full_messages.join(', ')
      end
      redirect_to new_user_path   
    end
  end

  def edit
    @user = User.find(session[:user_id])
  end
  def update
    @user = User.find(session[:user_id])
    vendor = Vendor.find(session[:user_id])
    @user.update(params.require(:user).permit(:username, :email, :password, :password_confirmation))
    username = params[:user][:username]
    email = params[:user][:email]
    vendor.update(username: username, email: email)
    flash[:notice] = "User Successfully Updated"
    redirect_to user_path(@user)
  end

  def destroy
    @user = User.find(session[:user_id])
    vendor = Vendor.find(session[:user_id])
    username = @user.username
    newUsername="#{username}DELETEDzz"
    @user.update(username:newUsername)
    vendor.update(username:newUsername)
    #@user.delete
    session[:user_id] = nil
    flash[:notice] = 'User Deleted!'
    redirect_to '/home'
  end
end
