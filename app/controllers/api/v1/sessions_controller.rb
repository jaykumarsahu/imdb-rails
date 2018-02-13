class Api::V1::SessionsController < ApplicationController

  skip_before_action :authenticate_request!

  def login
    user = User.find_by(email: params[:email].to_s.downcase)
    if user && user.authenticate(params[:password])
      auth_token = JsonWebTokenService.encode({user_id: user.id})
      render json: {auth_token: auth_token}, status: :ok
    else
      render json: {error: 'Invalid username / password', status: 'FAILED'}, status: :ok
    end
  end

end
