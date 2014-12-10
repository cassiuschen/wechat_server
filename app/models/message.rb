class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content,       type: String
  #field :createAt,      type: Time

  field :msgId,         type: String

  field :_id,           type: String, default: -> { msgId }

  field :type,          type: String

  field :flag,          type: Boolean, default: false #是否加星标

  belongs_to :author, class_name: "User", inverse_of: :message
  after_create do
    self.author.msgCount += 1
    self.author.save
  end

  def set_info
    user = self.author
    data = self.content.split
    if data[2]
      user.method(data[1].downcase + "=").call data[2]
      user.save
      "#{data[1]} has been set to #{data[2]}"
    else
      "WRONG PARAMS"
    end
  end

  def run_ruby
    order = (self.content.split - ["ruby"]).join(" ")
    `ruby -e '#{order}'`
  end

  def list_info
    "Your Info:\nName: #{self.author.name},\nEmail: #{self.author.email},\nSentMessage: #{self.author.msgCount}"
  end
end
