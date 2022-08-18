class Post < ApplicationRecord
    validates :title, presence: true, :uniqueness => {:case_sensitive => true}
    validates(:content, { :length => { :minimum => 250 } })
    validates(:summary, { :length => { :maximum => 250 } })
    validates :category, inclusion: { in: %w(Non-Fiction Fiction) }

    validate :clickbait?


  CLICKBAIT_PATTERNS = [
    /Won't Believe/i,
    /Secret/i,
    /Top \d/i,
    /Guess/i
  ]

  def clickbait?
    if CLICKBAIT_PATTERNS.none? { |pat| pat.match title }
      errors.add(:title, "must be clickbait")
    end
  end

end
