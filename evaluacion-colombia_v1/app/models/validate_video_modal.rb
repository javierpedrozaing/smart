class ValidateVideoModal
  include ActiveModel::Model

  attr_accessor(
    :presencia,
    :practica,
    :consentimiento,
    :manual
    )

  validates :presencia,  inclusion: { in: ["true", "false"] }
  validates :practica,  inclusion: { in: ["true", "false"] }
  validates :consentimiento,  inclusion: { in: ["true", "false"] }
  validates :manual,  inclusion: { in: ["true", "false"] }
end