class ConsignmentItem < ApplicationRecord
  belongs_to :consignment
  belongs_to :order_item
end
