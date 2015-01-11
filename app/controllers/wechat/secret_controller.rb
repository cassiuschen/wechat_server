require 'digest'
class Wechat::SecretController < Wechat::BaseController
  def token
    render text: params[:echostr]
  end

  def jsSDK
    render text: Token.get_token
  end

  def data
    render json: Wechat.all.last
  end

  def addData
    Wechat.addData params
    render json: Wechat.all.last
  end
end
