class CompaniesController < ApplicationController
	def index
		@assets = BaseUser.unique_companies
	end

	def show
		@assets = BaseUser.company(params[:id])
	end
end
