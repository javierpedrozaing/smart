class SecretariasEducacion < ActiveRecord::Base
  belongs_to :region, foreign_key: :region_id
  has_many :evaluadores
end
