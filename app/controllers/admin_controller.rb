class AdminController < ApplicationController
  include ApprovalNotifier
  before_action :authenticate_user!
  # before_action :admin_only
  # before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user, only: %i[edit update show approve_user]
  before_action :set_user, only: %i[edit update show]

  def all_users
    @all_users = User.all.where(user_type: 'trader')
  end

  def edit; end

  def show; end

  def new
    @user = User.new
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: 'User updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @user = User.new(user_params)
    @user.user_type = 'trader'

    if @user.save
      redirect_to admin_all_users_path, notice: 'User created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

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
    permitted_params = %i[first_name last_name email is_pending]
    permitted_params += %i[password password_confirmation] if params[:user][:password].present?
    params.require(:user).permit(permitted_params)
  end
end
