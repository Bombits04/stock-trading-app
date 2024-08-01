class TraderController < ApplicationController
  before_action :authenticate_user!
  # before_action :admin_only
  # before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user, only: %i[index]

  def index
  end

  private

  def set_user
    @user = User.find_by(id: current_user.id)
    unless @user
      redirect_to root_path, alert: 'Trader not found'
    end
  end

end
