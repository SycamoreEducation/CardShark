module CardShark
  module Trello
    @@base_uri = 'https://api.trello.com/1/cards/'
    
    def self.trello_defaults(path)
      uri = @@base_uri + path
      {defaults: {uri: uri, oauth: {token: CardShark.trello_token, key: CardShark.trello_key}}}
    end

    def self.card(id)
      options = self.trello_defaults("#{id}") 
      Http.http_request('Get', options)
    end

    def self.card_attachments(id)
      options = self.trello_defaults("#{id}/attachments") 
      Http.http_request('Get', options)
    end

    def self.link_card(id, params={})
      options = self.trello_defaults("#{id}/attachments").merge(params: params) 
      Http.http_request('Post', options)
    end

    def self.move_card(id, state_id)
      params = {idList: CardShark.list_state_map[state_id]}
      options = self.trello_defaults("#{id}").merge(params: params) 
      Http.http_request('Put', options)
    end
  end
end
