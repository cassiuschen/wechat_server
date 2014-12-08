class Wechat::MessagesController < Wechat::BaseController
  def create
    @user = User.find_or_create message_data[:author]
    if @user.messages.create type: message_data[:type],
      content: message_data[:content], msgId: message_data[:msgId]
      respond_message message_data, '你的消息小紫已收到并记录，稍后回复你~'
    else
      respond_message message_data, '抱歉，小紫的服务器好像出了一些问题，请重新发送消息~'
    end
  end

  private
  # 接收微信普通消息
  #<xml>
  #  <ToUserName><![CDATA[toUser]]></ToUserName>
  #  <FromUserName><![CDATA[fromUser]]></FromUserName>
  #  <CreateTime>1348831860</CreateTime>
  #  <MsgType><![CDATA[text]]></MsgType>
  #  <Content><![CDATA[this is a test]]></Content>
  #  <MsgId>1234567890123456</MsgId>
  #</xml>
  def message_data
    rawData = Nokogiri::XML params
    data = {
      author: rawData.xpath("//FromUserName").first.content,
      type: rawData.xpath("//MsgType").first.content,
      content: rawData.xpath("//Content").first.content,
      msgId: rawData.xpath("//MsgId").first.content
    }
    data
  end
end
