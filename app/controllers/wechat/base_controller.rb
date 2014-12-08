class Wechat::BaseController < ApplicationController
  protect_from_forgery with: :null_session
  helper_methods :respond_message

  # 被动返回消息
  #<xml>
  #  <ToUserName><![CDATA[toUser]]></ToUserName>
  #  <FromUserName><![CDATA[fromUser]]></FromUserName>
  #  <CreateTime>12345678</CreateTime>
  #  <MsgType><![CDATA[text]]></MsgType>
  #  <Content><![CDATA[你好]]></Content>
  #</xml>
  def respond_message(content, msg)
    message = {
      ToUserName: content[:author],
      FromUserName: content[:reciever],
      CreateTime: Time.now.to_i,
      MsgType: 'text',
      Content: msg
    }

    message.to_xml
  end
end
