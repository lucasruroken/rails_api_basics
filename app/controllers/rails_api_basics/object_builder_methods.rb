module RailsApiBasics
  module ObjectBuilderMethods
    def klass
      @klass ||= self.class.name.demodulize.underscore.gsub("_controller", "")
    end

    def serializer
      "#{klass.singularize.camelize}Serializer".constantize
    end

    def scope
      @scope ||= klass.singularize.camelize.constantize
    end

    def find_object
      @object = scope.find(params[:id])
    end

    def object_params
      raise "Should implement in inherited class"
    end

    # Methods per action
    # Index
    def scope_index
      scope.latest
    end

    def serializer_index_includes
      nil
    end

    # Create
    def scope_create
      scope
    end

    # Show
    def object_show
      @object
    end

    def serializer_show_includes
      nil
    end

    # Update
    def object_update
      @bject
    end

    # Destroy
    def object_destroy
      @object
    end
  end
end