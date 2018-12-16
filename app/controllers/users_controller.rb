class UsersController < ApplicationController
  def profile
    @user = current_user
    # リマインドメールを表示するために登録されているものを呼び出す。なければ新規登録のみ表示する。
    remindmails = current_user.remindmails
    if remindmails.empty?
      # 新規に作るようにする controllerではなにもしない
    else
      @remindmails = remindmails
    end
  end

  def update
    @user = current_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to home_url, notice: "User was successfully updated." }
        #format.json { render :show, status: :ok, location: @user }
      else
        format.html { redirect_to home_url, error: "User was failed to be updated." }
        #format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def area
  end

  def show
    @user = User.find(params[:id])
  end

  private

  # strong_parameter :public_name, :area,
  def user_params
    params.require(:user).permit(:public_name, :area1, :area2, :family, :avatar, :profile)
  end
end
