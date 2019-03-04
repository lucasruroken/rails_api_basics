module RailsApiBasics
  class Resources < BaseController
    include ObjectBuilderMethods

    before_action :find_object, only: [:show, :update, :destroy]

    def index
      @objects = scope_index.page(params[:page])
      render json: serializer.new(@objects, includes: serializer_index_includes).serialized_json
    end

    def create
      @object = scope_create.new(object_params)

      if @object.save
        render status: :created
      else
        render json: { errors: @object.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def show
      render json: serializer.new(@object, includes: serializer_show_includes).serialized_json
    end

    def update
      if object_update.update(object_params)
        render status: :no_content
      else
        render json: { errors: @object.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      object_destroy.destroy
      render status: :no_content
    end
  end
end