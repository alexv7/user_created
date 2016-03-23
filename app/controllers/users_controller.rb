class UsersController < ApplicationController
  def new
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


end
