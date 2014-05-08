class Record < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    date    :date, name: true
    content :text
    source  :sourcetext
    approved :boolean
    timestamps
  end
  attr_accessible :date, :content, :source, :category, :category_id, :approved
  validates :category, :content, :date, :source, presence: true

  belongs_to :category
  belongs_to :poster, :class_name => "User", :creator => true

  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator? ||
      acting_user.poster? || acting_user.editor?
  end

  def update_permitted?
    return true if acting_user.administrator? || acting_user.editor?
    !approved && poster_is?(acting_user) && none_changed?(:approved)
  end

  def destroy_permitted?
    acting_user.administrator? ||
      (!approved && poster_is?(acting_user))
  end

  def view_permitted?(field)
   return true if acting_user.administrator? || acting_user.editor?
   poster_is?(acting_user)
  end

end
