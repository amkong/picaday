# Homepage (Root path)
before do
  current_user
end

def current_user
  if session[:id]
    @current_user = User.find(session[:id])
  end
end

get '/' do
  erb :index
end

get '/images' do
  @images = Image.all
  erb :'images/index', layout: :'layouts/gallery'
end

get '/images/new' do
  @image = Image.new

  erb :'images/new'
end

post '/images' do
  current_challenge

  @image = Image.new(
    url: params[:url],
    title: params[:title],
    challenge_id: @current_challenge.id
  )

  if @image.save
    redirect "/images/#{@image.id}"
  else
    erb :'images/new'
  end
end

get '/images/:id' do
  @image = Image.find(params[:id])

  erb :'images/show'
end

post '/images/:id/upvote' do
  @image = Image.find(params[:id])

  @vote = Vote.new(image_id: params[:id])

  if @vote.save
    #blah
  end

  erb :'images/show'
end

get '/challenges' do
  @challenges = Challenge.all

  erb :'challenges/index'
end

get '/challenges/today' do
  @challenge = Challenge.today

  erb :'challenges/today', 
  layout: :'layouts/theme'
end

get '/challenges/yesterday' do
  @challenge = Challenge.yesterday
  @images = @challenge.images

  erb :'challenges/show'
end

get '/challenges/new' do
  @challenge = Challenge.new
  erb :'challenges/new', layout: :'layouts/global'
end

get '/challenges/:year/:month/:day' do
  @challenge = Challenge.find_by(date: Date.parse("#{params[:year]}-#{params[:month]}-#{params[:day]}"))
  
  if @challenge
    @images = @challenge.images
    @images = @images.sort do |a,b|
      b.votes.size <=> a.votes.size
    end
    erb :'challenges/show'
  end

  status 404
  erb :'system/404'
end

get '/challenges/:id' do
  @challenge = Challenge.find(params[:id])
  @images = @challenge.images
  erb :'challenges/show'
end

get '/login' do
  @user = User.new

  erb :'auth/login'
end
post '/login' do
  @user = User.authenticate(params[:email], params[:password])

  if @user
    # set session
    # redirect to homepage
    flash[:ok] = "You have successfully logged in"
    session[:id] = @user.id
    redirect '/'
  else
    erb :'auth/login'
  end
end

helpers do
  def current_challenge
    @current_challenge = Challenge.today
  end
end

not_found do
  erb :'system/404'
end

# Warden routes

# when user reach a protected route watched by Warden calls
post '/auth/unauthenticated' do
  session[:return_to] = env['warden.options'][:attempted_path]
  puts env['warden.options'][:attempted_path]
  flash[:error] = env['warden'].message  || 'You must to login to continue'
  redirect '/auth/login'
end

# to ensure user logout a session data removal
get '/logout' do
  env['warden'].raw_session.inspect
  env['warden'].logout
  flash[:success] = "Successfully logged out"
  redirect '/'
end

get '/protected' do
  env['warden'].authenticate!
  erb :'auth/protected'
end
