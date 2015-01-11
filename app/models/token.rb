require 'net/http'
require 'open-uri'
class Token
  include Mongoid::Document
  field :content, type: String
  field :timeout, type: Time

  WECHAT_TOKEN_API = 'https://api.weixin.qq.com/cgi-bin/token'

  WECHAT_APP_ID = "wxb38f702bbd64c06d"
  WECHAT_APP_SECRET = "1ad45394c5df55012af0a25a68ea2b62"
  #?grant_type=client_credential&appid=APPID&secret=APPSECRET

  def self.get_token
    if Token.all.size > 0
      if Time.now < Token.all.last.timeout
        @token = Token.all.last
      else
        @token = Token.get_new_token
      end
    else
      @token = Token.get_new_token
    end
    @token.content
  end

  def self.get_new_token
    open(Token.generate_api_url) do |http|
      @data = JSON.parse "#{http.read}"
    end
    puts @data
    Token.create_from_api @data
  end

  def self.create_from_api(data)
    Token.delete_all
    @token = Token.create(content: data["access_token"], timeout: Time.now + data["expires_in"].to_i)
    @token
  end

  private
  def self.generate_api_url(appid = Token::WECHAT_APP_ID, appsec = Token::WECHAT_APP_SECRET, grant_type = 'client_credential')
    "#{Token::WECHAT_TOKEN_API}?grant_type=#{ grant_type }&appid=#{ appid }&secret=#{ appsec }"
  end

end
