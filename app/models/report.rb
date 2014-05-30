class Report < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name        :string
    content     :html, limit: 16777215
    urlkey      :string, :unique
    timestamps
  end
  attr_accessible :name, :content, :urlkey

  before_create do |report|
    # Generate random url key
    report.urlkey = [(0..9),('a'..'z'), ('A'..'Z')].
                    map(&:to_a).flatten.
                    shuffle[0,32].join
  end

  def public_url
    Thread.current[:request].scheme+'://'+Thread.current[:request].host+'/digest/'+self.urlkey
  end

  # --- Permissions --- #

  def create_permitted?
    return false if acting_user.guest?
    acting_user.administrator? or
    acting_user.global_editor?
  end

  def update_permitted?
    return false if acting_user.guest?
    acting_user.administrator? or
    acting_user.global_editor?
  end

  def destroy_permitted?
    return false if acting_user.guest?
    acting_user.administrator? or
    acting_user.global_editor?
  end

  def view_permitted?(field)
    true
  end

end
