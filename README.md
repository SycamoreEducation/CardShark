# CardShark
Ruby on Rails engine for creating Clubhouse stories and syncing card/story movement from Clubhouse to Trello

## Usage
This RoR engine is setup to create a Clubhouse story from moving a Trello card from a webhook triggering list to a user specfic list. When the story is created in Clubhouse it will have all the following:
- Name 
- Description (plus a link to Trello card)
- Assigned Project
- Assigned Type (Feature, Bug, Chore)
- Labels
- Corresponding list/state

After the Cluhouse story gets created, when the story is moved into another list, it will move the linked card in Trello in a corresponding list.


## Installation
Add this line to your application's Gemfile:

```ruby
gem 'card_shark', git: 'https://github.com/SycamoreEducation/CardShark'
```

And then execute:
```bash
$ bundle
```

Mount in your routes config:
```ruby
Rails.application.routes.draw do
  mount CardShark::Engine, at: "/cardshark"
```

Set up an outgoing webhook request from both Trello and Clubhouse:
- [Trello Webhook](https://developers.trello.com/page/webhooks) pointing to `/cardshark/stories`
- [Clubhouse Webhook](https://help.clubhouse.io/hc/en-us/articles/115005093963-Setting-up-Outgoing-Webhooks-) pointing to `/cardshark/cards`

Create `config/initializers/card_shark.rb` to populate the api credentials and other configuration values:
```ruby
CardShark.trello_token = TRELLO_TOKEN
CardShark.trello_key = TRELLO_KEY
CardShark.clubhouse_token = CLUBHOUSE_TOKEN
CardShark.default_state_id = 1234 #State ID you want your story to be created in
#This links the Clubhouse and Trello list
CardShark.list_state_map = {
  500001056 => "5b858d319b555c7deaead0ad",
  500001055 => "5b80605d614475596ddde8c4",  
  500001054 => "5b80605d614475596ddde8c5",  #Clubhouse State ID => Trello List ID
  500001058 => "5b80605d614475596ddde8c6"
}
CardShark.default_project_id = 4321 #Default Project ID
#Links Trello labels with a coressponding Project ID
CardShark.label_project_map = {
  API: 1234,
  Mobiley: 1235,
  Frontend:: 1236
  Infrastructure: 1237
}
CardShark.clubhouse_base_url = "https://app.clubhouse.io/{WORKSPACE_NAME}/story/"
CardShark.watch_list = "Ready For Development" #Name of list that triggers the creation of Clubhouse story
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
