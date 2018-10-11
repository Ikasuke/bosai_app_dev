class ItemsController < ApplicationController


 def new
    
  ## Todo作成用の@categoresを準備
  categories = Category.all
  category_selects = Array.new()      # 空
  categories.each do |category|
      category_select = [category.category_name,category.id]
      category_selects.push(category_select)
  end
  @category_selects = category_selects


  render :layout => 'item_new.html.erb'
 end




 def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
   
    respond_to do |format|
      if @item.save
        format.html { redirect_to home_url, notice: 'item was successfully created.' }
        #format.json { render :show, status: :created, location: @category }
    
      else
        format.html { redirect_to home_url }
        #format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def item_params
    params.require(:item).permit(:item_name, :picture, :item_volume, :item_expiry, :item_public_memo, :item_private_memo, :item_open_flag, :uer_id, :category_id)
  end



end
