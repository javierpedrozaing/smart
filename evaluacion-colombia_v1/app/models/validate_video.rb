class ValidateVideo
  include ActiveModel::Model

  attr_accessor(
    :presencia
    )

  validates :presencia,  inclusion: { in: ["true", "false"] }
end