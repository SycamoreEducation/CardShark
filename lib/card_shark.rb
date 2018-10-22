require "card_shark/engine"

module CardShark
  mattr_accessor :trello_token
  mattr_accessor :trello_key
  mattr_accessor :clubhouse_token
  mattr_accessor :default_state_id
  mattr_accessor :list_state_map
  mattr_accessor :default_project_id
  mattr_accessor :label_project_map
  mattr_accessor :clubhouse_base_url
  mattr_accessor :watch_list
end
