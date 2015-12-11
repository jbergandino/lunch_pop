class UsersController < ApplicationController
  def show
  end

  def new
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

    user = User.new(fname:fname, lname:lname, username:username, email:email,
      password:password,password_confirmation:password_confirmation, phone:phone)

    if user.save
      flash[:alert] = "New User Created, Please Login"
      redirect_to login_path
    else
      if user.errors.full_messages.any?
        # user.errors.full_messages.each do |message| 
        #   flash[:alert] = user.errors.full_messages
        # end
        for i in 0..user.errors.full_messages.length-1 
          flash[:alert] = user.errors.full_messages[i]
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
    @user.update(params.require(:user).permit(:username, :password, :password_confirmation))
    flash[:notice] = "User Successfully Updated"
    redirect_to user_path(@user)
  end

  def destroy
    @user = User.find(session[:user_id])
    @user.delete
    session[:user_id] = nil
    flash[:notice] = 'User Deleted!'
    redirect_to root_path
  end
end
