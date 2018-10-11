class CategoriesController < ApplicationController
    before_action :authenticate_admin_user!

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

    def edit
    end

    private
    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:category_name)
    end



end
