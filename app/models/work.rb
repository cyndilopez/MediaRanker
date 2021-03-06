class Work < ApplicationRecord
  validates :title, presence: true
  validates :publication_year, presence: true
  validates :creator, presence: true
  validates :category, presence: true
  validates :description, presence: true

  has_many :votes
  has_many :users, through: :votes

  def self.category
    return ["album", "book", "movie"]
  end

  def self.media_votes(category)
    works = Work.where(category: category).left_joins(:votes).select(Arel.sql("works.*, COUNT(votes.id) as vote_count")).group(:id).order(Arel.sql("COUNT(votes.id) DESC")).limit(10)
    return works
  end

  def self.top_ten_media_votes(category)
    return self.media_votes(category).limit(10)
  end

  def self.media_vote_count(work)
    return work.votes.count
  end
end
