class Category < ActiveRecord::Base

  hobo_model # Don't put anything above this

  extend ActsAsTree::TreeView

  fields do
    name :string
    notes :html
    hide :boolean, default:false
    treeorder :string, chars: 20
    treelevel :integer
    children_count :integer
    timestamps
  end
  attr_accessible :name, :notes, :hide, :parent

  validates :name, presence: true
  validate :parent_cant_be_same_as_current_record

  def parent_cant_be_same_as_current_record
    errors.add(:parent, "can't be same as the category itself") if parent_id == id and not id.blank?
  end

  default_scope order('hex(treeorder)')
  self.per_page = 100

  has_many :records
  belongs_to :parent, :class_name => "Category"
  has_many :children, :class_name => "Category", :foreign_key => "parent_id", :dependent => :destroy

  acts_as_tree order: :name, counter_cache: true

  before_save { |this|
    this.parent_id = nil if this.id == this.parent_id

   # sibl = this.self_and_siblings.sort{ |a, b|
   #     ( (a_name = a.sort_name).class == Fixnum and (b_name = b.sort_name).class == Fixnum ) ?
   #         (a_name.to_i <= b_name.to_i ? -1 : 1) :
   #         (a_name.to_s <= b_name.to_s ? -1 : 1)
   # }
   # order_index = sibl.index(this)
   # sibl[order_index+1].save unless sibl[order_index+1].nil? #reorder

    order_index = this.id || Category.maximum(:id)+1;
    this.treeorder = (this.parent.nil? ? '' : this.parent.treeorder) + order_index.chr(Encoding::UTF_8)
    this.treelevel = this.ancestors.count
    this.children.each(&:save)
  }

  def treename
    ('&nbsp;&nbsp;'*self.treelevel.to_i+self.name).html_safe
  end

  def sort_name
    (/^\s*[0-9]/ =~ self.name).nil? ? self.name : /(^[0-9.]+) /.match(self.name)[1].split('.').last.to_i
  end


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
