class RemindmailsController < ApplicationController
  before_action :set_remindmail, only: [:update]


def create
  @remindmail = Remindmail.new(remindmail_params)
  @remindmail.user = current_user
    respond_to do |format|
      if @remindmail.save
        format.html { redirect_to home_url, notice: 'remindmail was successfully updated.' }
        #format.json { render :show, status: :ok, location: @user }
      else
        format.html { redirect_to home_url, error: 'remindmail was failed to be updated.'  }
        #format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
end

def update
   respond_to do |format|
    if @remindmail.update(remindmail_params)
      format.html { redirect_to home_url, notice: 'User was successfully updated.' }
      #format.json { render :show, status: :ok, location: @user }
    else
      format.html { redirect_to home_url, error: 'User was failed to be updated.'  }
      #format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end
end

private

def set_remindmail
    @remindmail = Remindmail.find(params[:id])
  end

  # strong_parameter
  def remindmail_params
    params.require(:remindmail).permit(:remind_email)
  end

end  #class end
