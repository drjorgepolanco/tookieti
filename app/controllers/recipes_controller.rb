class RecipesController < ApplicationController
  before_action :set_recipe,           only: [:show, :edit, :update, :like, :destroy]
  before_action :logged_in_user,     except: [:show, :index]
  before_action :require_recipe_owner, only: [:edit, :update, :destroy]  

  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 15)
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    if @recipe.save
      flash[:success] = "Tu receta fue creada!"
      redirect_to(recipes_path)
    else
      render(:new)
    end
  end

  def edit
  end

  def update
    if @recipe.update_attributes(recipe_params)
      flash[:success] = "Tu receta fue actualizada!"
      redirect_to(@recipe)
    else
      render(:edit)
    end
  end

  def like
    like = Like.create(like: true, user: current_user, recipe: @recipe)
    if like.valid?
      flash[:success] = "Hey! Te gustó la receta: \"#{@recipe.title.capitalize}\""
      redirect_to(:back)
    else
      flash[:alert] = "Sí, ya sabemos que te gustó."
      redirect_to(:back)
    end
  end

  def destroy
    @recipe.destroy
    flash[:success] = "Tu receta ha sido borrada."
    # redirect_to request.referrer || recipes_path
    redirect_to(recipes_path)
  end

  private

    def recipe_params
      params.require(:recipe).permit(:title,
                                     :description,
                                     :steps,
                                     :prep_time,
                                     :picture)
    end

    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def require_recipe_owner
      if current_user != @recipe.user
        flash[:alert] = "Solo puedes editar o borrar tus propias recetas."
        redirect_to(recipes_path)
      end
    end

end
