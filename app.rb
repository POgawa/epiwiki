require ("sinatra")
require ('sinatra/reloader')
require('./lib/##################')
also_reload('lib/**/*.rb')




get('/') do
   erb(:index)
 end
