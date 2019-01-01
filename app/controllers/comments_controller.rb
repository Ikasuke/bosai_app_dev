class CommentsController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @tab = params[:tab]
    if current_user == @item.user
      @item.comments.each do |comment|
        if comment.read == "unread"
          comment.read = "already"
          comment.save
        end  # if end
      end
    end # if end
    if params[:c_errors_messages]
      @c_errors_messages = params[:c_errors_messages]
    end
    render :layout => false
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    #item_id = @comment.item.id    いらないはず
    @commit_name = params.keys[3]
    respond_to do |format|
      if @comment.save
        format.js
      else
        format.js
      end  #if end
    end    # respond_to end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:comment_detail, :item_id)
  end
end  #class end
