class PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]

  def new
  end

  def create
      @user = User.find_by(email: params[:password_reset][:email].downcase)
      if @user
        @user.create_reset_digest
        @user.send_password_reset_email
        flash[:info] = "Email sent with password reset instructions"
        redirect_to root_url
      else
        flash.now[:danger] = "Email address not found"
        render 'new'
      end
  end

  def edit
  end

  private

    def get_user
          @user = User.find_by(email: params[:email])
    end

    # Confirms a valid user.
    def valid_user
      unless (@user && @user.activated? &&
              @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

end



# In Listing 10.51, compare the use of
#
# authenticated?(:reset, params[:id])
# to
#
# authenticated?(:remember, cookies[:remember_token])
# in Listing 10.26 and
#
# authenticated?(:activation, params[:id])
# in Listing 10.29. Together, these three uses complete the authentication
# methods shown in Table 10.1.
