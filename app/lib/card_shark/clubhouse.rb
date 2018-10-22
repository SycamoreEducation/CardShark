module CardShark
  module Clubhouse
    @@base_uri = 'https://api.clubhouse.io/api/v2/'

    def self.clubhouse_defaults(path)
      uri = @@base_uri + path
      {defaults: {uri: uri, oauth: {token: CardShark.clubhouse_token}}}
    end

    def self.story(id)
      options = self.clubhouse_defaults("stories/#{id}")
      Http.http_request('Get', options)
    end

    def self.create_story(params={})
      options = self.clubhouse_defaults('stories').merge(params: params)
      Http.http_request('Post', options)
    end
  end
end
