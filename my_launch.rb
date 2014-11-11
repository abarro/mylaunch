require 'sinatra/base'
require 'sinatra/assetpack'
require 'sass'
require 'data_mapper'
require 'dm-migrations'
require 'pony'
# require 'bourbon'
# require 'neat'
#gem do BD

#config do bd
# DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/mylaunch.db")
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/mylaunch.db")
 
class Users
  include DataMapper::Resource
  property :id, Serial
  property :email, String, :required => true, :format => :email_address
  property :created_at, DateTime
end
 
DataMapper.finalize.auto_upgrade!


class MyLaunch < Sinatra::Base
  set :sessions, true
  register Sinatra::AssetPack

  configure do
    
    Pony.options = {
      :via => :smtp,
      :via_options => {
        :address => 'smtp.sendgrid.net',
        :port => '587',
        :domain => 'heroku.com',
        :user_name => ENV['SENDGRID_USERNAME'],
        :password => ENV['SENDGRID_PASSWORD'],
        :authentication => :plain,
        :enable_starttls_auto => true
      }
    }
    end

  end
  
  assets do
     css :main, [
      '/css/*.css'
     ]
     css_compression :sass
  end

  get '/' do
    #formulario pra mandar o email
    erb :index
  end

  post '/' do
    n = Users.new
    n.email = params[:email]
    n.created_at = Time.now
    n.save
    #send email
    message = Pony.mail :to => 'abarro@gmail.com',
                        :from => 'abarro@gmail.com',
                        :subject => 'SendGrid Delivered!',
                        :body => 'Hello there. You look great today!'

    redirect '/obrigado'
  end

  get '/obrigado' do
    #obrigado
    erb :obrigado
  end

  get '/admin' do
    @users = Users.all :order => :id.desc
    erb :admin
  end

  run! if app_file == $0
end




