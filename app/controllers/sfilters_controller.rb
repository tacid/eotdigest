class SfiltersController < ApplicationController

  hobo_model_controller

  auto_actions :all, except: [ :new, :show ]

  def index
    filters = Sfilter.search(params[:search], :filter, :name).
                      order_by(parse_sort_param(:name,:filter))
    hobo_index filters
  end

end
