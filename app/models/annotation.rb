# == Schema Information
#
# Table name: annotations
#
#  id         :bigint           not null, primary key
#  content    :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Annotation < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
end
