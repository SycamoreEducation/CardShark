module CardShark
  module Clubhouse
    @@base_uri = 'https://api.clubhouse.io/api/v2/'

    def self.clubhouse_defaults(path)
      uri = @@base_uri + path
      token = CardShark.clubhouse_token

      {}.tap do |options|
        options[:defaults] = { uri: uri }
        options[:defaults][:oauth] = { token: token }
      end
    end

    def self.story(id)
      options = clubhouse_defaults("stories/#{id}")
      Http.http_request('Get', options)
    end

    def self.create_story(params={})
      options = clubhouse_defaults('stories').merge(params: params)
      Http.http_request('Post', options)
    end
  end
end
