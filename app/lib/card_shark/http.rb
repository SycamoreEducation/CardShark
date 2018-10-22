require 'net/http'

module CardShark
  module Http 
    def self.http_request(method, options={})
      uri = URI.parse(options[:defaults][:uri])
      uri.query = URI.encode_www_form(options[:defaults][:oauth])

      http = ::Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      
      request = ::Net::HTTP.const_get(method).new(uri) 
      request.content_type = "application/json"
      request.body = JSON.dump(options[:params]) unless options[:params].nil?
      JSON.parse(http.request(request).body)
    end
  end
end
