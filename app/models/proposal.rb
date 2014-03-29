class Proposal < ActiveRecord::Base

  belongs_to :user
  acts_as_voteable # thumbs_up gem

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 60 }
  validates :problem, presence: true, length: { maximum: 400 }
  validates :solution, presence: true, length: { maximum: 700 }

  default_scope -> { order('created_at DESC') }

  def score
    return self.plusminus
  end

  def upvotes
    return self.votes_for
  end

  def downvotes
    return self.votes_against
  end

  def summary(maxChars)
    summary = self.solution
    if summary.length < maxChars then
      return summary
    else
      indexOfLastCompleteWord = summary.rindex(" ", maxChars-3)   # provides space for the "..." (3 chars)
      return summary[0, indexOfLastCompleteWord] + "..."
    end
  end
end
