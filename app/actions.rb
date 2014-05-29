# Homepage (Root path)
get '/' do
  erb :index
end

get '/images' do
  @images = Image.all
  erb :'images/index'
end

get '/images/new' do
  @image = Image.new

  erb :'images/new'
end

post '/images' do
  @image = Image.new(
    url: params[:url],
    title: params[:title]
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

get '/challenges' do
  @challenges = Challenge.all

  erb :'challenges/index'
end

get '/challenges/today' do
  @challenge = Challenge.today

  erb :'challenges/today'
end

get '/challenges/yesterday' do
  @challenge = Challenge.yesterday
end

get '/challenges/:id' do
  @challenge = Challenge.find(params[:id])
end

get '/challenges/new' do
  @challenge = Challenge.new
end



