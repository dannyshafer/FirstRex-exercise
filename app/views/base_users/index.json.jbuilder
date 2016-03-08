json.array!(@base_users) do |base_user|
  json.extract! base_user, :id, :current_month_engagement, :previous_month_engagement, :role, :other
  json.url base_user_url(base_user, format: :json)
end
