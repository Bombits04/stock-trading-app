class TraderController < ApplicationController
  before_action :authenticate_user!
  # before_action :admin_only
  # before_action :configure_permitted_parameters, if: :devise_controller?

  def index
    @hello = "greetings!"
  end
end
