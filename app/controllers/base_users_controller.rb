class BaseUsersController < ApplicationController
  before_action :set_base_user, only: [:show, :edit, :update, :destroy]

  # GET /base_users
  # GET /base_users.json
  def index
    @base_users = BaseUser.all
  end

  # GET /base_users/1
  # GET /base_users/1.json
  def show
  end

  # GET /base_users/new
  def new
    @base_user = BaseUser.new
  end

  # GET /base_users/1/edit
  def edit
  end

  # POST /base_users
  # POST /base_users.json
  def create
    @base_user = BaseUser.new(base_user_params)

    respond_to do |format|
      if @base_user.save
        format.html { redirect_to @base_user, notice: 'Base user was successfully created.' }
        format.json { render :show, status: :created, location: @base_user }
      else
        format.html { render :new }
        format.json { render json: @base_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /base_users/1
  # PATCH/PUT /base_users/1.json
  def update
    respond_to do |format|
      if @base_user.update(base_user_params)
        format.html { redirect_to @base_user, notice: 'Base user was successfully updated.' }
        format.json { render :show, status: :ok, location: @base_user }
      else
        format.html { render :edit }
        format.json { render json: @base_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /base_users/1
  # DELETE /base_users/1.json
  def destroy
    @base_user.destroy
    respond_to do |format|
      format.html { redirect_to base_users_url, notice: 'Base user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_base_user
      @base_user = BaseUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def base_user_params
      params.require(:base_user).permit(:current_month_engagement, :previous_month_engagement, :role, :other)
    end
end
