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
    self.likes += 1
  end

  def dislike!
    self.dislikes += 1
  end

  def points
    likes - dislikes
  end

  def votes
    likes + dislikes
  end

  def long_lines
    body.lines.select { |line| line.length > 80 }
  end

  def length
    body.length
  end

  def truncate(limit)
    if body.length > limit && limit > 3
      body.slice(0..limit - 4) + '...'
    elsif limit <= 3
      '...'
    else
      body
    end
  end

  def contain?(word)
    if word.is_a?(Regexp)
      body.match word
    else
      body.include? word
    end
  end
end

class ArticlesFileSystem
  attr_reader :directory

  def initialize(directory)
    @directory = directory
  end

  def save(array_of_articles)
    array_of_articles.each do |article|
      title = article.title.downcase.gsub(' ', '_') + '.article'
      path = self.directory + '/' + title
      File.write(path, article.author + '||' + article.likes.to_s + '||' + article.dislikes.to_s + '||' + article.body)
    end
  end

  def load
    array = []
    Dir[self.directory + '/*.article'].each do |file|
      title = file.slice(9..-9).capitalize.gsub('_', ' ')
      IO.readlines(file).each do |line|
        author, likes, dislikes, body = line.split('||')
        article = Article.new(title, body, author)
        article.likes = likes.to_i
        article.dislikes = dislikes.to_i
        array << article
      end
    end
    array
  end
end
