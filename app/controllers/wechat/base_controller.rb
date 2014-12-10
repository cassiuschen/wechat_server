class Wechat::BaseController < ApplicationController
  protect_from_forgery with: :null_session
  helper_method :respond_message

  # 被动返回消息
  #<xml>
  #  <ToUserName><![CDATA[toUser]]></ToUserName>
  #  <FromUserName><![CDATA[fromUser]]></FromUserName>
  #  <CreateTime>12345678</CreateTime>
  #  <MsgType><![CDATA[text]]></MsgType>
  #  <Content><![CDATA[你好]]></Content>
  #</xml>
  def respond_message(author, sender, msg)
    message = {
      ToUserName: author,
      FromUserName: sender,
      CreateTime: Time.now.to_i,
      MsgType: 'text',
      Content: msg
    }

    render xml: message.to_xml
  end
end
