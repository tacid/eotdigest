class Record < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    date    :datetime, name: true
    content :html
    source  :sourcetext
    approved :boolean, default: true
    timestamps
  end
  set_search_columns :content
  attr_accessible :date, :content, :source, :category, :category_id, :approved
  validates :category, :content, :date, presence: true

  belongs_to :category
  belongs_to :poster, :class_name => "User"
  has_one    :region, :through => :poster

  before_create do
    self.poster = acting_user
  end
  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator? or
      acting_user.poster? or
      acting_user.editor?
  end

  def update_permitted?
    return true if acting_user.administrator? or acting_user.editor?
    poster_is?(acting_user) && none_changed?(:approved)
  end

  def destroy_permitted?
    return true if acting_user.administrator?
    poster_is?(acting_user)
  end
  def view_permitted?(field)
   return true unless acting_user.viewer?
   poster_is?(acting_user)
  end

end
