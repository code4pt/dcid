class Proposal < ActiveRecord::Base

  belongs_to :user

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 60 }
  validates :problem, presence: true, length: { maximum: 400 }
  validates :solution, presence: true, length: { maximum: 700 }

  default_scope -> { order('created_at DESC') }

  before_save {
    self.upvotes = 0
    self.downvotes = 0
  }

  def score
    self.upvotes - self.downvotes
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
