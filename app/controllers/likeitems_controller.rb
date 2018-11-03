class LikeitemsController < ApplicationController

def index
end

 def create
  #binding.pry
  @likeitem = Likeitem.new(likeitem_params)
  respond_to do |format|
    if @likeitem.save
      format.html { redirect_to items_url, notice: 'likeitem was successfully created.' }
      #format.json { render :show, status: :created, location: @category }
    else
      #render plain: "hello"
      format.json { render json: @likeitem.errors, status: :unprocessable_entity }
    
    end  #if end
  end    # respond_to end

end #create end


private


# Never trust parameters from the scary internet, only allow the white list through.
def likeitem_params
  params.require(:likeitem).permit(:item_id, :user_id)
end



end #class end
