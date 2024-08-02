class HomeController < ApplicationController
  before_action :authenticate_user!
  # before_action :admin_only
  # before_action :configure_permitted_parameters, if: :devise_controller?

  def index
    if current_user.user_type == "admin"
      redirect_to "/admin/all_users"
    else
      redirect_to '/home'
    end
  end

end
