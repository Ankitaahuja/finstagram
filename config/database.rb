configure do
if Sinatra::Application.development?
     ActiveRecord::Base.logger = Logger.new(STDOUT)
  set :database, {
  adapter: "sqlite3",
  database: "db/db.sqlite3"
  }
else
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres://xawzlemusybbgj:3492138090d2ef8bef0a35890acd1ffea30ba60b03aba2b6fbe586ac37374170@ec2-54-235-196-250.compute-1.amazonaws.com:5432/d6dns20jeipmko')
  set :database, {
  adapter: "postgresql",
  host: db.host,
  username: db.user,
  password: db.password,
  database: db.path[1..-1],
  encoding: "utf8"
  }
end

  # Load all models from app/models, using autoload instead of require
  # See http://www.rubyinside.com/ruby-techniques-revealed-autoload-1652.html
  Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
    filename = File.basename(model_file).gsub('.rb', '')
    autoload ActiveSupport::Inflector.camelize(filename), model_file
  end

end
