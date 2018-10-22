module CardShark
  class StoriesController < ApplicationController
    def index
      head :ok
    end

    def create
      trello_payload = JSON.parse(request.raw_post)

      if (data = trello_payload['action']['data']).include?('listAfter')
        list_after = data['listAfter']['name']
      end

      card_id = data['card']['id']
      attachments = Trello.card_attachments(card_id)
      linked = false
      attachments.each do |attachment|
        name = attachment['name']
        linked = true if name.include?(CardShark.clubhouse_base_url)
      end

      if !linked && list_after == CardShark.watch_list
        project_id = CardShark.default_project_id
        story_type = 'bug'
        labels = []

        card = Trello.card(card_id)
        card['labels'].each do |label|
          keys = CardShark.label_project_map.keys
          name = label['name'].to_sym
          project_id = CardShark.label_project_map[name] if keys.include?(name)
          story_type = name.downcase if [:Bug, :Feature, :Chore].include?(name)
          labels << {name: name}
        end

        params = {
          project_id: project_id,
          name: card['name'],
          description: "#{card['desc']} \n#{card['url']}",
          external_id: card['id'],
          workflow_state_id: CardShark.default_state_id,
          story_type: story_type,
          labels: labels
        }
        response = Clubhouse.create_story(params)

        Trello.link_card(card['id'], url: response['app_url'])
      end
      head :ok
    end
  end
end
