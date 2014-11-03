class Article
  attr_reader :title, :body, :author, :created_at
  attr_accessor :likes, :dislikes

  def initialize(title, body, author)
    @title, @body, @author = title, body, author
    @created_at = Time.now
    @likes = 0
    @dislikes = 0
  end
end
