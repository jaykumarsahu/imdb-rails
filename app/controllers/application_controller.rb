class ApplicationController < ActionController::API

  before_action :authenticate_request!

  protected

  # Validates the token and user and sets the @current_user scope
  def authenticate_request!
    if !payload || !JsonWebTokenService.valid_payload(payload.first)
      return invalid_authentication
    end

    load_current_user!
    invalid_authentication unless @current_user
  end

  # Returns 401 response. To handle malformed / invalid requests.
  def invalid_authentication
    render json: {error: 'Invalid Request'}, status: :unauthorized
  end

  private

  # Deconstructs the Authorization header and decodes the JWT token.
  def payload
    token = request.headers['Authorization'].split(' ').last
    JsonWebTokenService.decode(token)
  rescue
    nil
  end

  # Sets the @current_user with the user_id from payload
  def load_current_user!
    @current_user = User.find_by(id: payload[0]['user_id'])
  end

end
