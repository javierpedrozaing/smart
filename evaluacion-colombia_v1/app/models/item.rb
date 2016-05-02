class Item < ActiveRecord::Base
  has_many :grupo_itemes
  has_many :item_saltos
end
