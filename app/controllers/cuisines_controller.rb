class CuisinesController < ApplicationController
  
  def index
    @cuisines = Cuisine.order(:name)
  end

  def show
    @cuisine = Cuisine.find(params[:id])
    @recipes = @cuisine.recipes.paginate(page: params[:page], per_page: 15)
  end

  def new
    @cuisine = Cuisine.new
  end

  def create
    @cuisine = Cuisine.new(cuisine_params)
    if @cuisine.save
      flash[:success] = "La cocina fue creada!"
      redirect_to(cuisines_path)
    else
      render(:new)
    end
  end

  private

    def cuisine_params
      params.require(:cuisine).permit(:name)
    end
end
