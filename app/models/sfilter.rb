class Sfilter < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name   :string
    filter :string
    timestamps
  end
  attr_accessible :name, :filter

  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator? || acting_user.editor?
  end

  def update_permitted?
    acting_user.administrator? || acting_user.editor?
  end

  def destroy_permitted?
    acting_user.administrator? || acting_user.editor?
  end

  def view_permitted?(field)
    true
  end

end
