class CategoriesController < ApplicationController
    before_action :authenticate_admin_user!
    before_action :set_category, only: [:update, :destroy]

    def new
        @category = Category.new
      end

      def create
        @category = Category.new(category_params)
       
        respond_to do |format|
          if @category.save
            format.html { redirect_to adminhome_url, notice: 'Category was successfully created.' }
            #format.json { render :show, status: :created, location: @category }
          else
            format.html { redirect_to adminhome_url }
            #format.json { render json: @category.errors, status: :unprocessable_entity }
          end
        end
      end

    def update
   
      respond_to do |format|
        if @category.update(category_params)
          #format.html { redirect_to home_url, notice: ' category was successfully updated.' }
          format.json { render 'categories.json.jbuilder' }
        else
          format.html { redirect_to home_url }
          #format.json { render json: @to_do_item.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @category.destroy
      respond_to do |format|
        format.html { redirect_to home_url, notice: 'category was successfully destroyed.' }
        #format.json { head :no_content }
      end
    end # destroy end 


    private

    # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:category_name)
    end



end
