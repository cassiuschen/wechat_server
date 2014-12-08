class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content,       type: String
  field :createAt,      type: Time

  field :msgId,         type: String

  field :_id,           type: String, default: -> { msgId }

  field :type,          type: String

  field :flag,          type: Boolean, default: false #是否加星标

  belongs_to :author, class_name: "User", inverse_of: :message
end
