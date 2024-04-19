class User::SessionsController < Devise::SessionsController
  
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to movies_path, notice: "guestuserでログインしました。"
  end

end
