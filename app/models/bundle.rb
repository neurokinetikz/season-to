class Bundle < Sku
  has_many :line_items, as: :itemizable

  attr_accessible :line_items_attributes

  accepts_nested_attributes_for :line_items
end
