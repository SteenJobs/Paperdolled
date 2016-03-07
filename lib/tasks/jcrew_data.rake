namespace :jcrew_data do
  task :load_data => :environment do
    def post_init
      @parser = Yajl::Parser.new(:symbolize_keys => true)
    end

    def object_parsed(obj)
      if !obj[:results].nil?
        obj[:results].each do |x, y|
          Item.create!(picture: x[:image], price: x[:"price/_source"], name: x[:description], link: x[:item])
        end
      end
    end

    def connection_completed
      # once a full JSON object has been parsed from the stream
      # object_parsed will be called, and passed the constructed object
      @parser.on_parse_complete = method(:object_parsed)
    end

    def receive_data(data)
      # continue passing chunks
      @parser << data
    end
    
    file = File.new('jcrewdata')
    post_init
    @parser.parse(file, &connection_completed)
  end
end
