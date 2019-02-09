class InfoController < ApplicationController
  def index
    if browser.device.mobile? #browser.chrome? #
    else
      render :layout => "startpage.html.erb"
    end
  end
end
