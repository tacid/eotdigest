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
    errors.add(:parent, "can't be same as the category itself") if parent_id == id
  end

  has_many :records
  belongs_to :parent, :class_name => "Category"
  has_many :children, :class_name => "Category", :foreign_key => "parent_id", :dependent => :destroy

  acts_as_tree order: :name, counter_cache: true

  before_save { |this|
    this.parent_id = nil if this.id == this.parent_id
    this.treeorder = this.ancestors.map{|c| c.id.chr(Encoding::UTF_8) }.reverse.join + (this.id || Category.last.id+1).chr(Encoding::UTF_8)
    this.treelevel = this.ancestors.count
    this.children.each(&:save)
  }

  def treename
    ('&nbsp;&nbsp;'*self.treelevel.to_i+self.name).html_safe
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
