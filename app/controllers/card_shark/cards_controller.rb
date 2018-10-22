module CardShark
  class CardsController < ApplicationController
    def create
      payload = JSON.parse(request.raw_post)
      actions = payload['actions'].first

      if actions.include?('changes') && (changes = actions['changes']).include?('workflow_state_id')
        state_id = changes['workflow_state_id']['new']
        story_id = actions['id']
        story = Clubhouse.story(story_id)
        
        Trello.move_card(story['external_id'], state_id)
      end
      head :ok
    end
  end
end
