class BaseUsersController < ApplicationController
  require 'basecrm'
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
    puts "_"*100
    client.contacts.all.each do |user|
      #here's going to be the getting all users into local database
      puts user
    end
    puts client.contacts.all.count
    puts "_"*100
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
    client = BaseCRM::Client.new(access_token: "#{ENV['ACCESS_TOKEN']}")
    puts "_"*100
    client.notes.all.each do |note|
      puts note
    end
    puts client.notes.all.count
    puts "_"*100
    redirect_to '/'
  end

  def get_user_notes #modify this to take a user id and max user engagement
    client = BaseCRM::Client.new(access_token: "#{ENV['ACCESS_TOKEN']}")
    user = client.users.all.first    
    user_notes = client.notes.where(creator_id: user.id)
    notes_last_30_days = []
    notes_30_60_days = []
    puts "_"*100
    user_notes.each do |note|
      if note.created_at < Time.now && note.created_at >= (Time.now - 30.days)
        notes_last_30_days << note
      elsif note.created_at < (Time.now - 30.days) && note.created_at >= (Time.now - 60.days)
        notes_30_60_days << note
      else
        next
      end
    end
    puts notes_last_30_days.count
    puts notes_30_60_days.count
    puts "_"*100
    #ultimately this returns the two arrays for use by the get_user_engagement_score action
    redirect_to '/'
  end

  def get_thirty_day_user_engagement_score(thirty_day_notes, thirty_day_max_notes) #takes notes for last 30 and 60 days and max engagement of the group so far 
      #in this case the max is 100, user is 20
    return thirty_day_notes/thirty_day_max_notes*5
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
