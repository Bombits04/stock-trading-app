class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only
  # before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user, only: %i[edit update show]
  def all_users
    @all_users = User.all.where(user_type: 'trader')
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: 'User updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show; end

  private

  def admin_only
    unless current_user.user_type == 'admin'
      redirect_to root_path, alert: "Access denied."
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :is_pending)
  end
end
