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
    if body[word]
      true
    else
      false
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
      content = [article.author, article.likes.to_s, article.dislikes.to_s, article.body].join('||')
      File.write(path, content)
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

class WebPage
  class NoArticlesFound < StandardError
  end

  def initialize(directory = '/')
    @directory = directory
    @articles_temp = []
    @articles_db = ArticlesFileSystem.new(@directory)
  end

  def articles
    @articles_temp
  end

  def load
    @articles_db.load
  end

  def save
    articles_db.save(articles)
  end

  def new_article(title, body, author)
    @articles_temp << Article.new(title, body, author)
  end

  def longest_articles
    load.sort_by(&:length).reverse
  end

  def best_articles
    load.sort_by(&:points).reverse
  end

  def worst_articles
    load.sort_by(&:points)
  end

  def best_article
    raise WebPage::NoArticlesFound if load.empty?
    load.max_by(&:points)
  end

  def worst_article
    raise WebPage::NoArticlesFound if load.empty?
    load.min_by(&:points)
  end

  def most_controversial_articles
    load.sort_by(&:votes).reverse
  end

  def votes
    load.map(&:votes).inject(0, :+)
  end

  def authors
    load.map(&:author).uniq
  end

  def authors_statistics
    result = Hash.new(0)
    load.map(&:author).each { |elem| result[elem] += 1}
    result
  end

  def best_author
    authors_statistics.max_by { |key, value| value }.first
  end

  def search(query)
    load.select { |article| article if article.contain?(query) }
  end
end
