require 'digest'
class Wechat::SecretController < Wechat::BaseController
  def token
    render text: params[:echostr]
  end
end
