class Report < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name        :string
    content     :html, limit: 16777215
    urlkey      :string
    timestamps
  end
  attr_accessible :name, :content, :urlkey
  validates :urlkey, uniqueness: true, unless: 'urlkey.blank?'

  before_create do |report|
    # Generate random url key
    report.urlkey = Report.generate_key
  end

  def public_url
    request = Thread.current[:request]
    port = ":"+request.port.to_s unless (request.scheme == 'http'  and request.port == 80) or
                                        (request.scheme == 'https' and request.port == 443)

    request.scheme+'://'+request.host+port.to_s+'/digest/'+self.urlkey
  end

  # --- Permissions --- #

  def self.generate_key
    key=""
    while key.blank? or Report.find_by(urlkey: key)
      leters_array = [(0..9),('a'..'z'), ('A'..'Z')].map(&:to_a).flatten*100
      key = leters_array.shuffle[0,32].join
    end
    key
  end

  def create_permitted?
    return false if acting_user.guest?
    acting_user.administrator? or
    acting_user.editor?
  end

  def update_permitted?
    return false if acting_user.guest?
    acting_user.administrator? or
    acting_user.editor?
  end

  def destroy_permitted?
    return false if acting_user.guest?
    acting_user.administrator? or
    acting_user.editor?
  end

  def view_permitted?(field)
    true
  end

end
