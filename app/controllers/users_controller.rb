class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  
  def new 
    @user=User.new
  end 

  
  def create
    @user = User.new(user_params) 
    if @user.save
      session[:user_id] = @user.id
      flash[:success]="You have successfully signed up."
      redirect_to user_path(@user)
    else 
      render 'new'
    end 
  end 
  
  def edit 
  end 
  
  def update
    if @user.update(user_params)
      flash[:success]="Your information has been successfully updated."
      redirect_to user_path(@user)
    else
      render 'edit'
    end 
  end 
  
  def show
    @user_articles=@user.articles.paginate(page:params[:page],per_page:5)
  end
  
  def index
    @users = User.paginate(page:params[:page],per_page:5)
  end 
  
  def destroy
    if @user.destroy 
      flash[:danger]="User and all articles created by use have been deleted"
      redirect_to users_path
    end 
    
  end 
  
  private 
    
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end 

    def set_user
       @user = User.find(params[:id])
    end
    
    def require_same_user
      if  current_user != @user and !current_user.admin?
        flash[:danger]=" You can only edit your own account"
        redirect_to root_path
      end 
    end 
    
    def require_admin
      if logged_in? and !current_user.admin?
        flash[:danger]="Only admin users can perform that action"
      end 
    end 
    
    
end 
