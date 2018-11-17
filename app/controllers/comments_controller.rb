class CommentsController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    #binding.pry
    render :layout => false
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to home_url, notice: "comment was successfully created." }
        #format.json { render :show, status: :created, location: @category }
      else
        format.html { redirect_to home_url }
        #format.json { render json: @category.errors, status: :unprocessable_entity }
      end  #if end
    end    # respond_to end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:comment_detail, :item_id)
  end
end  #class end
