# Homepage (Root path)
get '/' do
  erb :index
end

get '/images' do
  @images = Image.all
end
