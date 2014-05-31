# Homepage (Root path)
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

get '/auth/sign_in' do
  erb :'auth/sign_in'
end

get '/auth/sign_up' do
  erb :'auth/sign_up'
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
  @images = @challenge.images
  @images = @images.sort do |a,b|
     b.votes.size <=> a.votes.size
  end
  erb :'challenges/show'
end

get '/challenges/:id' do
  @challenge = Challenge.find(params[:id])
  @images = @challenge.images
  erb :'challenges/show'
end

helpers do
  def current_challenge
    @current_challenge = Challenge.today
  end
end

not_found do
  erb :'system/404'
end