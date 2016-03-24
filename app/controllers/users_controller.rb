class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    #  debugger
=begin
Check in rails s
Whenever you’re confused about something in a Rails application, it’s a good
practice to put debugger close to the code you think might be causing the
trouble. Inspecting the state of the system using byebug is a powerful method for
tracking down application errors and interactively debugging your application.
=end
  end

  def create
   @user = User.new(user_params)
   if @user.save
     flash[:success] = "Welcome to the Sample App!"
     redirect_to @user
    #  redirect_to user_url(@user)   #same as above
   else
     render 'new'
   end
 end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

end
