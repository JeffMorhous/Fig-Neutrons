class UserController < ApplicationController
  def signup
    @account_page = true
  end

  def login
    @account_page = true
  end

  def logout
    log_out
    redirect_to '/user/login'
  end

end
