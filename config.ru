require 'sequel'
Sequel.connect('sqlite://db/q16.db')
Dir[File.expand_path('api/*.rb', __dir__)].sort.each do |f|
  require f
end
run Quick16::API
