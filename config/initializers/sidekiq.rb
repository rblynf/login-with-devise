redis_server = 'localhost' # redis服务器
redis_port   = 6379 # redis端口
redis_db_num = 0 # redis 数据库序号


Sidekiq.configure_server do |config|
	config.redis = { url: "redis://#{redis_server}:#{redis_port}/#{redis_db_num}" }
end

Sidekiq.configure_client do |config|
	config.redis = { url: "redis://#{redis_server}:#{redis_port}/#{redis_db_num}" }
end