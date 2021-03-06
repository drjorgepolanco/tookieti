class UsersController < ApplicationController
  before_action :logged_in_user, except: [:show, :new,  :create]
  before_action :correct_user,   only:   [       :edit, :update]
  before_action :set_user,       only:   [:show, :edit, :update]
  before_action :admin_user,     only:   [:destroy]
  
  def show
    @recipes = @user.recipes.paginate(page: params[:page], per_page: 15)
    redirect_to(root_url) and return unless @user.activated
  end

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Por favor, chequea tu email para activar tu cuenta." +
                     "Si no encuentras el email, chequea en tu folder de spam."
      redirect_to(root_url)
    else
      render(:new)
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Tu perfil fue actualizado satisfactoriamente."
      redirect_to(@user)
    else
      render(:edit)
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "El usuario ha sido borrado."
    redirect_to(users_url)
  end

  def following
    @title = "Sigue a"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page], per_page: 20)
    render('show_follow')
  end

  def followers
    @title = "Lo Siguen"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page], per_page: 20)
    render('show_follow')
  end

  private
    def user_params
      params.require(:user).permit(:first_name, 
                                   :last_name, 
                                   :email,
                                   :bio,
                                   :password, 
                                   :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def correct_user
      @user = User.find(params[:id])
      if !current_user?(@user)
        flash[:alert] = "Solo puedes modificar tu propio perfil."
        redirect_to(root_url)
      end 
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
