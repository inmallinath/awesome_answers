class Product < ActiveRecord::Base
  before_destroy :notify_admin

  # valid_names != %w(Apple Microsoft Sony)

  validates :name, presence: true, uniqueness: { case_sensitive: false }
   validates_exclusion_of :name, in: %w( microsoft apple sony ), message: "Product name %{value} is proprietary and is not allowed"
  validates :price, presence: true,
            :numericality => { greater_than: 0, less_than_or_equal_to: 1000 }

  def self.priced_between
    where(["price between ? and ?", 100, 300]).order("name").limit(10)
    # where(["title || body ILIKE ?", "%#{term}%"]).order("view_count DESC")
  end
  scope :updated_after, -> (date) {where ("date(updated_at) > ? "),date}

  def self.recent_three
    where(["price != sale_price"]).order("sale_price, created_at DESC").limit(3)
  end

  def notify_admin
    logger.info "Product is about to be deleted"
  end
end
