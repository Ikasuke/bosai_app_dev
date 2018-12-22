class FavoritesController < ApplicationController
  before_action :set_favorite, only: [:destroy]

  def create
    @favorite = Favorite.new(favorite_params)
    respond_to do |format|
      if @favorite.save
        #to_user_id = favorite_params[:to_user_id]
        #ro_user = User.find(to_user_id)
        #@to_user = @favorite.to_user
        @count = @favorite.to_user.favorites_of_to_user.count
        #@count = @item.likeitems.count   murmur.user.favorites_of_to_user.count
        format.js
        # format.html { redirect_to items_url, notice: "likeitem was successfully created." }
        #format.json { render json: {status: "success", count: @count} }
      else
        @likeitem_d = Likeitem.where(favorite_params)
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end  #if end
    end    # respond_to end
  end # create end

  def destroy
    @favorite.destroy
    @count = @favorite.to_user.favorites_of_to_user.count
    respond_to do |format|
      format.js
    end
  end #destroy end

  private

  def set_favorite
    @favorite = Favorite.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def favorite_params
    params.require(:favorite).permit(:to_user_id, :from_user_id)
  end
end  #class end
