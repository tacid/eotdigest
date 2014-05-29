class Report < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name        :string
    content     :html, limit: 16777215
    urlkey      :string
    timestamps
  end
  attr_accessible :name, :content

  before_create do |report|
    # Generate random url key
    report.urlkey = [(0..9),('a'..'z'), ('A'..'Z')].
                    map(&:to_a).flatten.
                    shuffle[0,32].join
  end

  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator? or
    acting_user.global_editor?
  end

  def update_permitted?
    acting_user.administrator? or
    acting_user.global_editor?
  end

  def destroy_permitted?
    acting_user.administrator? or
    acting_user.global_editor?
  end

  def view_permitted?(field)
    true
  end

end
