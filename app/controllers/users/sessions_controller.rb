# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render json: { user: user_payload(resource) }, status: :ok
  end

  def respond_to_on_destroy
    if current_user
      render json: { message: "Logged out" }, status: :ok
    else
      render json: { message: "No active session" }, status: :unauthorized
    end
  end

  def user_payload(user)
    {
      id: user.id,
      email: user.email,
      first_name: user.first_name,
      last_name: user.last_name
    }
  end
end
