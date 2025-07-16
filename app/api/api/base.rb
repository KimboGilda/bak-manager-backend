module API
  class Base < Grape::API
    mount API::V1::Tasks
  end
end
