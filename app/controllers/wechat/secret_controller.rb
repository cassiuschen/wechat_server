require 'digest'
class Wechat::SecretController < Wechat::BaseController
  def token
    params[:echostr] #if secret_data == params[:signature]
  end

  private
  def secret_data
    token = ""
    Settings.wechat.token.split("").sort.each{|i| token << i}

    timestamp = ""
    params[:timestamp].split("").sort.each{|i| timestamp << i}

    nonce = ""
    params[:nonce].split("").sort.each{|i| nonce << i}

    Digest::SHA1.hexdigest token + timestamp + nonce
  end
end
