class Idea < ActiveRecord::Base
    belongs_to :user
    validates :title, :content, presence: true
    validates :title, uniqueness: true
end
