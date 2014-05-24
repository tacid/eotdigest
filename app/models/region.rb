class Region < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string
    timestamps
  end
  attr_accessible :name

  validates :name, presence: true

  has_many :users
  has_many :records, :through => :users

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
