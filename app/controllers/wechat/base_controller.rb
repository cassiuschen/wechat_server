class Wechat::BaseController < ApplicationController
  protect_from_forgery with: :null_session
  helper_method :respond_message
  #before_action :check_signature

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
      ToUserName: sender,
      FromUserName: author,
      CreateTime: Time.now.to_i,
      MsgType: 'text',
      Content: msg
    }

    message.to_xml(root: "xml", children: "item", skip_instruct: true, skip_types: true)
  end

  private
  def check_signature
    @calc = Digest::SHA1.hexdigest [Settings.wechat.token, params[:timestamp], params[:nonce]].sort.join
    unless @calc == params[:signature]
      render text: "Promission Deny"
    end
  end
end
