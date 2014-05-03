class Record < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    date    :date, name: true
    content :text
    source  :sourcetext
    timestamps
  end
  attr_accessible :date, :content, :source, :category, :category_id
  validates :category, :content, :date, :source, presence: true

  belongs_to :category

  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end
