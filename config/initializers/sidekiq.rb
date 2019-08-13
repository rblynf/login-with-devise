redis_server = 'localhost' # redis服务器
redis_port   = 6379 # redis端口
redis_db_num = 0 # redis 数据库序号


Sidekiq.configure_server do |config|
	config.redis = { url: "redis://#{redis_server}:#{redis_port}/#{redis_db_num}" }

  schedule_file = "config/sidekiq_cron.yml"
  if File.exists?(schedule_file) && Sidekiq.server?
  	p "111 "*10
  	p YAML.load_file(schedule_file)
    Sidekiq::Cron::Job.load_from_hash! YAML.load_file(schedule_file)
  end
end

Sidekiq.configure_client do |config|
	config.redis = { url: "redis://#{redis_server}:#{redis_port}/#{redis_db_num}" }
end
