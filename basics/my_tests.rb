require 'minitest/autorun'
require './example'

class ArticleTest < Minitest::Test
  def setup
    @article = Article.new('title', 'bodybodybody', 'author')
  end

  def test_initialization
    assert_equal 'title', @article.title
    assert_equal 'bodybodybody', @article.body
    assert_equal 'author', @article.author
    assert_in_delta Time.now, @article.created_at
    assert_equal 0, @article.likes
    assert_equal 0, @article.dislikes
  end

  def test_initialization_with_anonymous_author
    @article2 = Article.new('title', 'body')
    assert_equal 'title', @article2.title
    assert_equal 'body', @article2.body
    assert_equal nil, @article2.author
    assert_in_delta Time.now, @article2.created_at
    assert_equal 0, @article2.likes
    assert_equal 0, @article2.dislikes
  end

  def test_liking
    @article.like!
    assert_equal 1, @article.likes
  end

  def test_disliking
    @article.dislike!
    assert_equal 1, @article.dislikes
  end

  def test_points
    5.times { @article.like! }
    2.times { @article.dislike! }
    assert_equal 3, @article.points
  end

  def test_long_lines
    @article2 = Article.new('title', 'text' * 80 + "\n" + 'body' * 10)
    assert_equal ['text' * 80], @article2.long_lines
  end

  def test_truncate
    assert_equal '...', @article.truncate(3)
  end

  def test_truncate_when_limit_is_longer_then_body
    assert_equal 'bodybodybody', @article.truncate(15)
  end

  def test_truncate_when_limit_is_same_as_body_length
    assert_equal 'bodybody...', @article.truncate(11)
  end

  def test_length
    assert_equal 12, @article.length
  end

  def test_votes
    5.times { @article.like! }
    2.times { @article.dislike! }
    assert_equal 7, @article.votes
  end

  def test_contain
    assert_equal true, @article.contain?('body')
  end
end

class ArticlesFileSystemTest < Minitest::Test
  def setup
    @article = Article.new('title', 'bodybodybody', 'author')
    @article2 = Article.new('title2', 'bodybodybody2', 'author2')

    @directory = Dir.mktmpdir
    @articles_db = ArticlesFileSystem.new(@directory)
    @articles = [@article, @article2]
  end

  def test_saving
    @articles_db.save(@articles)
    assert File.exists?("#{@directory}/title.article")
    assert File.exists?("#{@directory}/title2.article")

    loaded_file = File.read("#{@directory}/title.article")
    loaded_file2 = File.read("#{@directory}/title2.article")

    assert_equal 'author||0||0||bodybodybody', loaded_file
    assert_equal 'author2||0||0||bodybodybody2', loaded_file2
  end

  def test_loading
    @articles_db.save(@articles)
    loaded_articles = @articles_db.load

    assert_equal 'author', loaded_articles[0].author
    assert_equal 0, loaded_articles[0].likes
    assert_equal 0, loaded_articles[0].dislikes
    assert_in_delta Time.now, loaded_articles[0].created_at
    assert_equal 'bodybodybody', loaded_articles[0].body
    assert_equal 'Title', loaded_articles[0].title

    assert_equal 'author2', loaded_articles[1].author
    assert_equal 0, loaded_articles[1].likes
    assert_equal 0, loaded_articles[1].dislikes
    assert_in_delta Time.now, loaded_articles[1].created_at
    assert_equal 'bodybodybody2', loaded_articles[1].body
    assert_equal 'Title2', loaded_articles[1].title
  end

  def teardown
    FileUtils.rm_rf(@directory)
  end
end
