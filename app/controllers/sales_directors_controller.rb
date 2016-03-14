class SalesDirectorsController < ApplicationController
	def index
		@assets = BaseUser.unique_sales_directors
	end

	def show
		@user = BaseUser.find_by_id(params[:id])
		@assets = BaseUser.sales_director(@user.name)
	end

	def sales_directors_users
		
	end
end
