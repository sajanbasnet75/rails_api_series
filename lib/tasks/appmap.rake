namespace :appmap do
  if %w[test development].member?(Rails.env)
    # In a Rails app, add a dependency on the :environment task.
    AppMap::Swagger::RakeTask.new(:swagger, [] => [ :environment ]).tap do |task|
      task.project_name = 'Rails api'
      # You may not have a VERSION file. Do what works best for you.
      # task.project_version = "v#{File.read(File.join(Rails.root, 'VERSION')).strip}"
    end

    AppMap::Swagger::RakeDiffTask.new(:'swagger:diff', [ :base, :swagger_file ]).tap do |task|
      # Default base; can be overridden by the :base task argument
      # task.base = 'remotes/origin/master'
      # Default swagger file; can be overridden by the :swagger_file task argument
      task.swagger_file = 'swagger/openapi_stable.yaml'
    end
  end
end