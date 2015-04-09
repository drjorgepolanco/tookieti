class IngredientsController < ApplicationController
  def index
    @ingredients = Ingredient.order(:name)
  end

  def show
    @ingredient = Ingredient.find(params[:id])
    @recipes    = @ingredient.recipes.paginate(page: params[:page], per_page: 15)
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)

    if @ingredient.save
      flash[:success] = "El ingrediente ha sido creado!"
      redirect_to(ingredients_path)
    else
      render(:new)
    end
  end

  def destroy
    @ingredient = Ingredient.find(params[:id])
    @ingredient.destroy
    flash[:success] = "El ingrediente ha sido borrado."
    redirect_to(ingredients_path)
  end

  private

    def ingredient_params
      params.require(:ingredient).permit(:name)
    end
end
