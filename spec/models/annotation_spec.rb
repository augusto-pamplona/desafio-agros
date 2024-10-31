require 'rails_helper'

RSpec.describe Annotation, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:annotation)).to be_valid
    end
  end
end
