require 'rubygems'
require 'bundler/setup'

require 'active_support/all'

# Load Sinatra Framework (with AR)
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'warden'
require 'bcrypt'
require 'pry'

require 'dotenv'
Dotenv.load

require_relative '../lib/image_importer'
require_relative '../lib/challenge_importer'

# use Rack::Session::Cookie, secret: "IdoNotHaveAnySecret"
# use Rack::Flash, accessorize: [:error, :success]

APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))
APP_NAME = APP_ROOT.basename.to_s

# Sinatra configuration
configure do
  set :root, APP_ROOT.to_path
  set :server, :puma

  enable :sessions
  set :session_secret, ENV['SESSION_KEY']

  set :views, File.join(Sinatra::Application.root, "app", "views")
end

use Warden::Manager do |config|
      # serialize user to session ->
      config.serialize_into_session{|user| user.id}
      # serialize user from session <-
      config.serialize_from_session{|id| User.get(id) }
      # configuring strategies
      config.scope_defaults :default, 
                    strategies: [:password], 
                    action: 'auth/unauthenticated'
      config.failure_app = self
end

Warden::Strategies.add(:password) do
  def flash
    env['x-rack.flash']
  end

  # valid params for authentication
  def valid?
    params['user'] && params['user']['username'] && params['user']['password']
  end

  # authenticating user
  def authenticate!
    # find for user
    user = User.first(username: params['user']['username'])
    if user.nil?
      fail!("Invalid username, doesn't exists!")
      flash.error = ""
    elsif user.authenticate(params['user']['password'])
      flash.success = "Logged in"
      success!(user)
    else
      fail!("There are errors, please try again")
    end
  end
end

# use Rack::Flash, accessorize: [:error, :success]
# Set up the database and models
require APP_ROOT.join('config', 'database')

# Load the routes / actions
require APP_ROOT.join('app', 'actions')
