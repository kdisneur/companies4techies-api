root = "#{Dir.getwd}"

activate_control_app "tcp://127.0.0.1:9293"
bind "unix://#{root}/tmp/companies4techies-api.sock"
pidfile "#{root}/tmp/pids/companies4techies-api.pid"
rackup "#{root}/config.ru"
state_path "#{root}/tmp/pids/companies4techies-api.state"
