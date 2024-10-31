require 'rails_helper'

RSpec.describe Api::V1::AnnotationsController, type: :controller do
  describe "GET #index" do
    it "returns a list of annotations with status 200" do
      create_list(:annotation, 3)

      get :index, format: :json

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['annotations'].size).to eq(3)
    end
  end

  describe "GET #show" do
    context "when annotation exists" do
      it "returns the annotation with status 200" do
        annotation = create(:annotation)

        get :show, params: { id: annotation.id }, format: :json

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['annotation']['id']).to eq(annotation.id)
      end
    end

    context "when annotation does not exist" do
      it "returns status 404 with error message" do
        get :show, params: { id: 0 }, format: :json

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq("Annotation not found")
      end
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new annotation and returns it with status 201" do
        valid_params = { title: "New Annotation", content: "Content of the new annotation" }

        expect {
          post :create, params: { annotation: valid_params }, format: :json
        }.to change(Annotation, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['annotation']['title']).to eq("New Annotation")
      end
    end

    context "with invalid parameters" do
      it "does not create a new annotation and returns status 422" do
        invalid_params = { title: "", content: "" }

        expect {
          post :create, params: { annotation: invalid_params }, format: :json
        }.not_to change(Annotation, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).to include("Title can't be blank")
      end
    end
  end

  describe "PUT #update" do
    let(:annotation) { create(:annotation, title: "Old Title") }

    context "with valid parameters" do
      it "updates the annotation and returns it with status 200" do
        valid_params = { title: "Updated Title", content: annotation.content }

        put :update, params: { id: annotation.id, annotation: valid_params }, format: :json

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['annotation']['title']).to eq("Updated Title")
      end
    end

    context "with invalid parameters" do
      it "does not update the annotation and returns status 422" do
        invalid_params = { title: "" }

        put :update, params: { id: annotation.id, annotation: invalid_params }, format: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).to include("Title can't be blank")
      end
    end
  end

  describe "DELETE #destroy" do
    context "when annotation exists" do
      it "deletes the annotation and returns status 200" do
        annotation = create(:annotation)

        expect {
          delete :destroy, params: { id: annotation.id }, format: :json
        }.to change(Annotation, :count).by(-1)

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq("Annotation deleted successfully")
      end
    end

    context "when annotation does not exist" do
      it "returns status 404 with error message" do
        delete :destroy, params: { id: 0 }, format: :json

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq("Annotation not found")
      end
    end
  end
end
