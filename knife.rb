# encoding: utf-8
cache_type 'BasicFile'
cache_options :path => File.join(ENV['HOME'], '.chef', 'checksums')
knife['secret_file'] = 'test/vagrant_only_secret'
knife['data_bag_path'] = 'test/data_bags'
