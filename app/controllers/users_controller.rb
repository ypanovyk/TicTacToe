class UsersController < ApplicationController

  before_filter :find_user, only:[:show, :edit, :update]
  before_filter :require_signin, only:[:edit, :update, :index]
  before_filter :correct_user, only:[:edit, :update]

  def show
  end

  def new
    @user=User.new
  end
  
  def create
    @user=User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Changes successfuly saved."
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page:params[:page])
  end

  private
    
    def find_user
      @user = User.find(params[:id])
    end

    def correct_user
      redirect_to root_path unless current_user?(@user)
    end
end
