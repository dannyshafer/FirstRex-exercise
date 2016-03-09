class BaseUsersController < ApplicationController
  require 'basecrm'
  require 'httparty'
  require 'json'
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

  def get_all_users
    client = BaseCRM::Client.new(access_token: "#{ENV['ACCESS_TOKEN']}")
    users = []
    thirty_day_notes, sixty_day_notes = get_all_notes
    client.contacts.all.each do |user|
      users << user
      @user = BaseUser.create(id: user.id)
    end
    thirty_day_notes.each do |user_id|
      @user = BaseUser.find_by_id(user_id)
      @user.current_month_engagement += 1
    end
    sixty_day_notes.each do |user_id|
      @user = BaseUser.find_by_id(user_id)
      @user.previous_month_engagement += 1
    end
    max_30_day_notes = BaseUser.order("current_month_engagement DESC").first.current_month_engagement
    max_60_day_notes = BaseUser.order("previous_month_engagement DESC").first.current_month_engagement
    puts "_"*100
    puts max_30_day_notes
    puts max_60_day_notes
    puts "_"*100
    users.each do |user|
      @user = BaseUser.find_by_id(user.id)
      @user.current_month_engagement_score = get_thirty_day_user_engagement_score(@user.current_month_engagement, max_30_day_notes)
      @user.previous_month_engagement_score = get_thirty_day_user_engagement_score(@user.current_month_engagement, max_60_day_notes)
    end
    redirect_to '/'
  end

  def get_user_info
    client = BaseCRM::Client.new(access_token: "#{ENV['ACCESS_TOKEN']}")
    user = client.users.all.first    
    puts "_"*100
    puts user
    puts "_"*100
    redirect_to '/'
  end

  def get_all_notes
    thirty_day_notes = []
    sixty_day_notes = []
    iterating = true
    page = 1
    while iterating do
      notes = HTTParty.get("https://api.getbase.com/v2/notes?page=#{page}&per_page=100", :headers => {"Accept" => "application/json", "Authorization" => "Bearer e33471b597454cf865278806dd50e854a700b98fa5ef8efec5be01cc532d094e", "User-Agent" => "Httparty"})
      if notes['items'] == nil || notes['items'] == []
        iterating = false 
      else
        notes['items'].each do |note|
          if note['data']['created_at'] > (Time.now - 30.days)
            puts "found one in the last month"
            thirty_day_notes << note['data']['creator_id']
          elsif note['data']['created_at'] > (Time.now - 60.days)
            puts "found one in the last two months"
            sixty_day_notes << note['data']['creator_id']
          else
            puts "found nothing B!"
          end
        end
        page += 1
      end
    end
    print thirty_day_notes 
    print sixty_day_notes
    return thirty_day_notes, sixty_day_notes
    render :nothing => true
  end

  def get_thirty_day_user_engagement_score(thirty_day_notes, thirty_day_max_notes) 
    return ((thirty_day_notes/thirty_day_max_notes)*5).to_i
  end

  def get_sixty_day_user_engagement_score(sixty_day_notes, sixty_day_max_notes) 
    return ((sixty_day_notes/sixty_day_max_notes)*5).to_i
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
