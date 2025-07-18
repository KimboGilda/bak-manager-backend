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
    
      desc "Get a task based on a given ID", {
        summary: "Get a task based on a given ID",
        success: [{code: 200, message: "Success"}],
        failure: [
          {code: 400, message: "Bad request"},
          {code: 404, message: "Task not found"},
          {code: 500, message: "Internal server error"}
        ]
      }

      params do
        requires :id, type: String, desc: "Task ID"
      end

      get ":id" do
        task = Task.find_by(id: params[:id])
        error!("Task not found", 404) unless task

        Panko::Response.new(TaskSerializer.new.serialize(task))
        end

      desc "Delete a task with a given ID", {
        summary: "Delete a task with a given ID",
        success: [{code: 201, message: "Task successfully deleted"}],
        failure: [
          {code: 400, message: "Bad request"},
          {code: 404, message: "Task not found"},
          {code: 500, message: "Internal server error"}
        ]
      }

      params do
        requires :id, type: String, desc: "Task ID"
      end

      delete ":id" do
        task = ::Task.find_by(id: params[:id])
        error!("Task not found", 404) unless task

        if task.destroy
          status 201
          {message: "Task successfully deleted"}
        else
          error!("Unexpected error occured while deleting task", 500)
        end
      end

      desc "Update a task given its ID", {
        summary: "Update a task given its ID",
        success: [{code: 201, message: "Task successfully updated"}],
        failure: [
          {code: 400, message: "Bad request"},
          {code: 404, message: "Task not found"},
          {code: 500, message: "Internal server error"}
        ]
        }

        params do
          requires :id, type: String, desc: "Task ID"
          requires :Task, type: Hash do
            optional :title, type: String, documentation: {example: "Do the dishes.."}
          end
        end

        patch ":id" do
          task = ::Task.find_by(id: params[:id])
          error!("Task not found", 404) unless task

          updated_attrs = declared(params, include_missing: false).except(:id)
          task.assign_attributes(updated_attrs[:task])

          if task.save
            Panko::Response.new(task: TaskSerializer.new.serialize(task))
          else
            error!(task.errors.full_message.to_sentence, 400)
          end
        end



      


      end
    end
  end
end
