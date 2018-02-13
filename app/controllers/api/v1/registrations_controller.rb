class Api::V1::RegistrationsController < ApplicationController

  skip_before_action :authenticate_request!, only: [:create]

  def create
    sleep(2)

    begin
      user = User.new(user_params)
      if user.save
        msg = "User has been signed up successfully."
        render json: {
          status: "SUCCESS",
          message: msg,
          user: user.as_json(only: [:first_name, :last_name, :email, :phone, :address, :city, :state, :zip, :country])
        }, status: :ok
      else
        render json: { status: "FAILED", error: user.errors.full_messages.join("\n") }, status: :ok
      end
    rescue Exception => e
      render json: { status: "FAILED", error: e.message }, status: :ok
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :phone,
      :address,
      :city,
      :state,
      :zip,
      :country,
      :password,
      :password_confirmation
    )
  end
end
