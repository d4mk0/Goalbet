set :stage, :production
set :branch, 'master'
set :deploy_to, '/work/www/betcel.ru'

server "betcel.ru", roles: [:web, :app, :db], user: 'd4mk0', primary: true
