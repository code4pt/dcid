class Proposal < ActiveRecord::Base
  is_impressionable

  belongs_to :user
  acts_as_voteable # thumbs_up gem
  acts_as_taggable # acts_as_taggable_on gem

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 60 }
  validates :problem, presence: true, length: { maximum: 400 }
  validates :solution, presence: true, length: { maximum: 700 }

  before_save :normalize_tags

  default_scope -> { order('created_at DESC') }

  def score
    self.plusminus
  end

  def upvotes
    self.votes_for
  end

  def downvotes
    self.votes_against
  end

  def total_votes
    self.votes_for + self.votes_against
  end

  def normalize_tags
    # Make lowercase
    self.tag_list.map!(&:downcase)

    # Replace any non-word ([^\w]) characters with a hyphen
    self.tag_list.map! {|tag| tag.gsub(/[^\w]+/i,'-')}
  end

  def summary(maxChars)
    summary = self.solution
    if summary.length < maxChars then
      summary
    else
      indexOfLastCompleteWord = summary.rindex(" ", maxChars-3)   # provides space for the "..." (3 chars)
      summary[0, indexOfLastCompleteWord] + "..."
    end
  end
end
