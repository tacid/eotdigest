class Category < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string
    notes :html
    hide :boolean, default:false
    timestamps
  end
  attr_accessible :name, :notes, :hide

  validates :name, presence: true

  has_many :records

  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator? || acting_user.editor?
  end

  def update_permitted?
    acting_user.administrator? || acting_user.editor?
  end

  def destroy_permitted?
    acting_user.administrator? or
      self.created_at > DateTime.now - 15.minutes
  end

  def view_permitted?(field)
    true
  end

end
