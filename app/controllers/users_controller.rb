class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      redirect_to user_path(@user), notice: 'Account was successfully created.'
      flash[:success] = 'Account was successfully created.'
    else
      render 'new'
      flash[:alert] = 'There was an error while creating this account please try again in a few moments.'
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Account was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(
        :name,
        :admin,
        :author,
        :no_rights,
        :email,
        :password,
        :password_confirmation
    )
  end
end
