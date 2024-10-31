# frozen_string_literal: true

module Api
  module V1
    class AnnotationsController < ApplicationController
      rescue_from StandardError, with: :handle_standard_error

      def index
        annotations = Annotation.select(:id, :title, :content, :created_at).page(params[:page]).per(20)

        render json: { annotations: annotations, total: annotations.total_count }, status: :ok
      end

      def show
        annotation = Annotation.find_by(id: params[:id])

        if annotation.nil?
          render json: { error: "Annotation not found" }, status: :not_found
        else
          render json: { annotation: annotation }, status: :ok
        end
      end

      def create
        annotation = Annotation.new(annotation_params)

        if annotation.save
          render json: { annotation: annotation }, status: :created
        else
          render json: { errors: annotation.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        annotation = Annotation.find_by(id: params[:id])

        if annotation.nil?
          render json: { error: "Annotation not found" }, status: :not_found
        elsif annotation.update(annotation_params)
          render json: { annotation: annotation }, status: :ok
        else
          render json: { errors: annotation.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        annotation = Annotation.find_by(id: params[:id])

        if annotation.nil?
          render json: { error: "Annotation not found" }, status: :not_found
        elsif annotation.destroy
          render json: { message: "Annotation deleted successfully" }, status: :ok
        else
          render json: { error: "Failed to delete annotation" }, status: :unprocessable_entity
        end
      end

      private

      def annotation_params
        params.require(:annotation).permit(:title, :content)
      end

      def handle_standard_error(exception)
        render json: { error: "An unexpected error occurred: #{exception.message}" }, status: :internal_server_error
      end
    end
  end
end
