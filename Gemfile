source "https://rubygems.org"

gem 'sinatra-base'
gem 'sinatra-assetpack'
gem 'sinatra-asset-pipeline'
gem 'sass'
gem 'datamapper'
# gem 'sqlite3' 
# gem 'dm-sqlite-adapter'
gem 'pony'


group :production do
    gem "pg"
    gem "dm-postgres-adapter"
end

group :development, :test do
    gem "sqlite3"
    gem "dm-sqlite-adapter"
end