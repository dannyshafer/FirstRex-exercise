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
		BaseUser.where(current_month_engagement_score: 4...5).each do |user|
			names << user.name
		end
		return BaseUser.where(current_month_engagement_score: 4...5).count, names
	end
end
