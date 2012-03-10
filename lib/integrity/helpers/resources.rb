module Integrity
  module Helpers
    module Resources
      def current_project
        @project ||= Project.first(:permalink => params[:project]) or
          raise Sinatra::NotFound
      end

      def current_build
        @build ||= current_project.builds.get(params[:build]) or
          raise Sinatra::NotFound
      end

      def update_notifiers_of(project)
        if params["notifiers"]
          project.update_notifiers(params["enabled_notifiers"] || [], params["notifiers"])
        end
      end

      def artifact_files(build)
        files = build.artifact_files.dup
        files.each do |file|
          url = artifact_path(build, file[:relative_path])
          file[:url] = url
        end
        files
      end
    end
  end
end
