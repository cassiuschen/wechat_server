require 'digest'
class Wechat::SecretController < Wechat::BaseController
  def token
    if secret_data == params[:signature]
      render text: params[:echostr]
    else
      render text: "Promission Deny"
      puts "========================== Debug ========================="
      puts "Type   ".rjust(12," ") + "|" + "Origin".rjust(20," ") + "  |" + "Calc".rjust(20," ")
      puts "TOKEN:  ".rjust(12," ") + "|" + Settings.wechat.token.rjust(20," ") + "  |" + @token.rjust(20," ")
      puts "Timestamp:  ".rjust(12," ") + "|" + params[:timestamp].rjust(20," ") + "  |" + @timestamp.rjust(20," ")
      puts "NONCE:  ".rjust(12," ") + "|" + params[:nonce].rjust(20," ")  + "  |" + @nonce.rjust(20," ")
      puts "----------------------------------------------------------"
      puts "signature:  ".rjust(12," ") + params[:signature]
      puts "STR:        ".rjust(12, " ") + @str
      puts "Digest:     ".rjust(12," ") + secret_data
    end
  end

  private
  def secret_data
    @token = Settings.wechat.token.split("").sort.join

    @timestamp = params[:timestamp].split("").sort.join

    @nonce = params[:nonce].split("").sort.join

    @str = (Settings.wechat.token + params[:timestamp] + params[:nonce]).split("").sort.join

    Digest::SHA1.hexdigest [Settings.wechat.token, params[:timestamp], params[:nonce]].sort.join
  end
end
