class AdminApi::AdminsController < ApplicationController
  before_filter :authenticate_admin!

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      redirect_to admin_api_dashboard_path, notice: "Admin created"
    else
      redirect_to admin_api_dashboard_path, alert: "Admin could not be saved"
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end
end
