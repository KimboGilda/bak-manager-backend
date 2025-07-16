module Api
  class Base < Grape::API
    format :json
    prefix :api

    mount Api::V1::Tasks

    add_swagger_documentation(
      api_version: 'v1',
      hide_documentation_path: false,
      mount_path: '/swagger_doc',
      hide_format: true
    )
  end
end
