class CategoriesController < ApplicationController

  hobo_model_controller

  auto_actions :all, except: [ :new, :show ]

  def index
    categories = Category.order_by(parse_sort_param(:name, :notes))
    hobo_index categories
  end
end
