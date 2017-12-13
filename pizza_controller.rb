require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative('./models/pizza.rb')

# INDEX route

get('/pizzas') do
  @pizzas = Pizza.all()
  erb(:index)

end

# NEW route

get('/pizzas/new') do
  erb(:new)
end

# SHOW route

get('/pizzas/:id') do

  id = params[:id]
  @pizza = Pizza.find(id)
  erb(:show)
end

# CREATE route

post('/pizzas') do

  @pizza = Pizza.new(params)
  @pizza.save()

  erb(:create)
end

# DELETE route

post('/pizzas/:id/delete') do
  id = params[:id]
  @pizza = Pizza.find(id)
  @pizza.delete()

  redirect "/pizzas"

end

# EDIT route
# two stage route: find then update database

get('/pizzas/:id/edit') do
  @pizza = Pizza.find(params[:id])
  erb(:edit)
end

post('/pizzas/:id') do
  @pizza = Pizza.new(params)
  @pizza.update
  redirect "/pizzas/#{@pizza.id}"
end
