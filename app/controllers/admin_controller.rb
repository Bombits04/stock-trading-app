class AdminController < ApplicationController
  include ApprovalNotifier
  before_action :authenticate_user!
  # before_action :admin_only
  # before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user, only: %i[edit update show approve_user]
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

  def approve_user
    if @user.update(is_pending: false)
      redirect_to edit_user_path(@user), notice: 'User was successfully approved.'
    else
      render :edit
    end
  end

  private

  # def admin_only
  #   unless current_user.admin?
  #     redirect_to root_path, alert: "Access denied."
  #   end
  # end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :is_pending)
  end
end
