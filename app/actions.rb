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
