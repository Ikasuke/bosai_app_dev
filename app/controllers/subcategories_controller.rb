class SubcategoriesController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :set_subcategory, only: [:update, :destroy]

  def index
    @category = Category.find(params[:category_id])
  end

  def create
    @subcategory = Subcategory.new(subcategory_params)
    @category = @subcategory.category
    respond_to do |format|
      if @subcategory.save
        format.html { redirect_to adminhome_url, notice: "Subategory was successfully created." }
        format.js
      else
        format.html { redirect_to adminhome_url }
        #format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @category = @subcategory.category
    @action = params[:action]
    respond_to do |format|
      if @subcategory.update(subcategory_params)
        #format.html { redirect_to home_url, notice: " subcategory was successfully updated." }
        #format.json { render "categories.json.jbuilder" }
        format.js
      else
        format.html { redirect_to home_url }
        #format.json { render json: @to_do_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category = @subcategory.category
    @action = params[:action]
    @subcategory.destroy
    respond_to do |format|
      #format.html { redirect_to home_url, notice: "category was successfully destroyed." }
      #format.json { render "categories.json.jbuilder" }
      format.js
    end
  end # destroy end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_subcategory
    @subcategory = Subcategory.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def subcategory_params
    params.require(:subcategory).permit(:subcategory_name, :category_id)
  end
end # class end
