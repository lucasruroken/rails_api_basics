module RailsApiBasics
  class Resources < BaseController
    before_action :find_object, only: [:show, :update, :destroy]

    def index
      @objects = scope.latest.page(params[:page])
      render json: serializer.new(@objects).serialized_json
    end

    def create
      @object = scope.new(object_params)

      if @object.save
        render status: :created
      else
        render json: { errors: @object.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def show
      render json: serializer.new(@object).serialized_json
    end

    def update
      if @object.update(object_params)
        render status: :no_content
      else
        render json: { errors: @object.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      @object.destroy
      render status: :no_content
    end

    private

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
  end
end