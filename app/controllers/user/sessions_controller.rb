class User::SessionsController < Devise::SessionsController
  before_action :reject_end_user, only: [:create]

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to movies_path, notice: "ゲストユーザーとしてログインしました."
  end

  private
  
  def reject_end_user
    @user = User.find_by(email: params[:user][:email])
    if @user
      if @user.valid_password?(params[:user][:password]) && !@user.active_for_authentication?
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
        redirect_to new_user_registration_path
      end
    end
  end
  
end
