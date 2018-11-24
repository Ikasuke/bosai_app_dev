class LikeitemsController < ApplicationController
  before_action :set_likeitem, only: [:destroy]

  def index
  end

  def create
    @likeitem = Likeitem.new(likeitem_params)
    respond_to do |format|
      if @likeitem.save
        @item = Item.find(params[:likeitem][:item_id])
        @count = @item.likeitems.count
        format.js
        # format.html { redirect_to items_url, notice: "likeitem was successfully created." }
        #format.json { render json: {status: "success", count: @count} }
      else
        @likeitem_d = Likeitem.where(likeitem_params)
        format.json { render json: @likeitem.errors, status: :unprocessable_entity }
      end  #if end
    end    # respond_to end
  end #create end

  def destroy
    @item = @likeitem.item
    @likeitem.destroy
    @count = @item.likeitems.count
    respond_to do |format|
      format.js
      #format.html { redirect_to items_url, notice: "likeitem was successfully destroyed." }
      #format.json { head :no_content }
    end
  end

  private

  def set_likeitem
    @likeitem = Likeitem.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def likeitem_params
    params.require(:likeitem).permit(:item_id, :user_id)
  end
end #class end
