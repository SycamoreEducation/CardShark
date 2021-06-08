module CardShark
  module Trello
    @@base_uri = 'https://api.trello.com/1/cards/'

    def self.trello_defaults(path)
      uri = @@base_uri + path
      token = CardShark.trello_token
      key = CardShark.trello_token

      {}.tap do |options|
        options[:defaults] = { uri: uri }
        options[:defaults][:oauth] = { token: token, key: key }
      end
    end

    def self.card(id)
      options = trello_defaults(id.to_s)
      Http.http_request('Get', options)
    end

    def self.card_attachments(id)
      options = trello_defaults("#{id}/attachments")
      Http.http_request('Get', options)
    end

    def self.link_card(id, params={})
      options = trello_defaults("#{id}/attachments").merge(params: params)
      Http.http_request('Post', options)
    end

    def self.move_card(id, state_id)
      params = { idList: CardShark.list_state_map[state_id] }
      options = trello_defaults(id.to_s).merge(params: params)
      Http.http_request('Put', options)
    end
  end
end
