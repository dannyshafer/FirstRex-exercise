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
end
