class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :body, presence: true, allow_blank: false #comment cannot be blank
  # only one comment per user per movie allowed
  validates :user_id, uniqueness: {scope: :movie_id, message: "cannot add more then one comment to specific movie. To do that delete your previous comment."}

end
