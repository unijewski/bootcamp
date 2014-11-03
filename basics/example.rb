class Article
  attr_reader :title, :body, :author, :created_at
  attr_accessor :likes, :dislikes

  def initialize(title, body, author = nil)
    @title, @body, @author = title, body, author
    @created_at = Time.now
    @likes = 0
    @dislikes = 0
  end

  def like!
    @likes += 1
  end

  def dislike!
    @dislikes += 1
  end

  def points
    @likes - @dislikes
  end

  def votes
    @likes + @dislikes
  end

  def long_lines
    @body.lines.select { |line| line.length > 80 }
  end

  def length
    @body.length
  end

  def truncate(limit)
    @body = @body.slice!(0..limit - 4) + '...' if @body.length > limit
    @body
  end

  def contain?(word)
    if word.is_a?(Regexp)
      @body.match word
    else
      @body.include? word
    end
  end
end

class ArticlesFileSystem
  attr_accessor :directory

  def initialize(directory)
    @directory = directory
  end
end
