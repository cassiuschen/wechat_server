class WechatData
  include Mongoid::Document
  field :pengyouquan, type: Integer
  field :friend, type: Integer
  field :qq, type: Integer

  def addData(params)
    @data = WechatData.all.last
    case params["type"]
      when 'pengyouquan' then @data.pengyouquan += 1
      when 'friend' then @data.friend += 1
      when 'qq' then @data.qq += 1
    end
    @data.save
  end
end
