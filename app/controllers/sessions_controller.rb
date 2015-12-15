class SessionsController < ApplicationController
  def new
  end
  def login
    if session[:user_id]
      redirect_to root_path
    end
  end
  def create
    #if Vendor.where(username: params[:username]).first.vend==false
    if User.where(username: params[:username]).first.present?
      if User.where(username: params[:username]).first.lname=="placeholdlname"
        @user = Vendor.where(username: params[:username]).first
      else
        @user = User.where(username: params[:username]).first
      end
    end
    if @user 
      if @user.password == params[:password] 
        session[:user_id] = @user.id
        flash[:notice] = "Hello #{@user.username}!"
        redirect_to root_path
      else
        flash[:alert] = "Login Not Successful, Please Try Again"
        redirect_to login_path
      end
    else
      flash[:alert] = "Login Not Successful, Please Try Again"
      redirect_to login_path
    end
  end	

  def vendorCreate

    @user = Vendor.where(username: params[:username]).first
    
    if @user 
      if @user.password == params[:password] 
        session[:user_id] = @user.id
        flash[:notice] = "Hello #{@user.username}!"
        redirect_to root_path
      else
        flash[:alert] = "Login Not Successful, Please Try Again"
        redirect_to login_path
      end
    else
      flash[:alert] = "Login Not Successful, Please Try Again"
      redirect_to login_path
    end
  end 

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Successfully Logged Out"
    redirect_to root_path
  end
end
