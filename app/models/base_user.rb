class BaseUser < ActiveRecord::Base
	def self.ones
		names = []
		BaseUser.where(current_month_engagement_score: 0...1).each do |user|
			names << user.name
		end
		return BaseUser.where(current_month_engagement_score: 0...1).count, names 
	end

	def self.twos
		names = []
		BaseUser.where(current_month_engagement_score: 1...2).each do |user|
			names << user.name
		end
		return BaseUser.where(current_month_engagement_score: 1...2).count, names
	end

	def self.threes
		names = []
		BaseUser.where(current_month_engagement_score: 2...3).each do |user|
			names << user.name
		end
		return BaseUser.where(current_month_engagement_score: 2...3).count, names
	end

	def self.fours
		names = []
		BaseUser.where(current_month_engagement_score: 3...4).each do |user|
			names << user.name
		end
		return BaseUser.where(current_month_engagement_score: 3...4).count, names
	end

	def self.fives
		names = []
		BaseUser.where(current_month_engagement_score: 4...5.1).each do |user|
			names << user.name
		end
		return BaseUser.where(current_month_engagement_score: 4...5.1).count, names
	end

	def self.previous_ones
		names = []
		BaseUser.where(previous_month_engagement_score: 0...1).each do |user|
			names << user.name
		end
		return BaseUser.where(previous_month_engagement_score: 0...1).count, names 
	end

	def self.previous_twos
		names = []
		BaseUser.where(previous_month_engagement_score: 1...2).each do |user|
			names << user.name
		end
		return BaseUser.where(previous_month_engagement_score: 1...2).count, names
	end

	def self.previous_threes
		names = []
		BaseUser.where(previous_month_engagement_score: 2...3).each do |user|
			names << user.name
		end
		return BaseUser.where(previous_month_engagement_score: 2...3).count, names
	end

	def self.previous_fours
		names = []
		BaseUser.where(previous_month_engagement_score: 3...4).each do |user|
			names << user.name
		end
		return BaseUser.where(previous_month_engagement_score: 3...4).count, names
	end

	def self.previous_fives
		names = []
		BaseUser.where(previous_month_engagement_score: 4...5.1).each do |user|
			names << user.name
		end
		return BaseUser.where(previous_month_engagement_score: 4...5.1).count, names
	end

	def self.average_current_month_engagement_score
		return BaseUser.average(:current_month_engagement_score).to_f
	end

	def self.average_previous_month_engagement_score
		return BaseUser.average(:previous_month_engagement_score).to_f
	end

	def self.max_current_month_engagement_score
		return BaseUser.order("current_month_engagement DESC")[2].current_month_engagement
	end

	def self.max_previous_month_engagement_score
		return BaseUser.order("previous_month_engagement DESC")[2].previous_month_engagement
	end

	def self.current_most_engaged_user(offset = 0)
		return BaseUser.order("current_month_engagement DESC")[offset]
	end

	def self.previous_most_engaged_user(offset = 0)
		return BaseUser.order("previous_month_engagement DESC")[offset]
	end

	def self.company(company_name)
		users = []
		current_company_engagement = 0
		previous_company_engagement = 0
		BaseUser.all.each do |user|
			if user.other != nil
				container = user.other.split(",").first[12..-2]
				if company_name == container 
					users << user 
					current_company_engagement += user.current_month_engagement
					previous_company_engagement += user.previous_month_engagement
				end 
			end
		end
		return users.count, current_company_engagement, previous_company_engagement, users
	end

	def self.sales_director(sales_director_name)
		users = []
		current_sales_director_engagement = 0
		previous_sales_director_engagement = 0
		BaseUser.all.each do |user|
			if user.other != nil
				container = user.other.split(",").last[19..-3]
				if sales_director_name == container 
					users << user 
					current_sales_director_engagement += user.current_month_engagement
					previous_sales_director_engagement += user.previous_month_engagement
				end 
			end
		end
		return users.count, current_sales_director_engagement, previous_sales_director_engagement, users
	end

	def self.unique_companies
		users = []
		BaseUser.all.each do |user|
			if user.other != nil
				users << user.other.split(",").first[12..-2]
			end
		end
		return users.uniq.sort
	end

	def self.unique_sales_directors
		users = []
		BaseUser.all.each do |user|
			if user.other != nil
				users << user.other.split(",").last[19..-3]
			end
		end
		return users.uniq.sort
	end
end
