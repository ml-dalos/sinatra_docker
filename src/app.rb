# frozen_string_literal: true

require 'base64'
require 'digest'

class SinatraDockerApp < Sinatra::Application
  get '/' do
    render_index
  end

  post '/encode' do
    if params['base64']
      render_index(Base64.encode64(params['encrypted_string']))
    elsif params['md5']
      render_index(Digest::MD5.hexdigest(params['encrypted_string']))
    else
      raise NameError
    end
  rescue StandardError
    redirect '/error', 302
  end

  not_found do
    erb :'404'
  end

  get '/error' do
    erb :'500'
  end

  error do
    env['sinatra.error']
  end

  private

  def render_index(encrypted_string = '')
    erb :index, locals: { encrypted_string: encrypted_string }
  end
end
