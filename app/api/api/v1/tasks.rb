module Api
  module V1
    class Tasks < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api

      resource :tasks do
        desc 'Get all tasks', {
          summary: "Getting all tasks",
          success: [{code: 200, message: "Success"}],
          failure: [
            {code: 400, message: "Bad request"},
            {code: 500, message: "Internal server error"}
          ]
        } 
        get do
          Panko::ArraySerializer.new(Task.all, each_serializer: TaskSerializer).to_json
        end
      end

    end
  end
end
