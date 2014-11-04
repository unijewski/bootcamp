require 'minitest/autorun'
require './example'

class ArticleTest < Minitest::Test
  def setup
    @article = Article.new('title', 'body')
  end

  def test_initialization
    assert_instance_of Article, Article.new('title', 'body', 'author')
  end

  def test_initialization_with_anonymous_author
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
  end

  def test_truncate
  end

  def test_truncate_when_limit_is_longer_then_body
  end

  def test_truncate_when_limit_is_same_as_body_length
  end

  def test_length
    assert_equal 4, @article.length
  end

  def test_votes
    5.times { @article.like! }
    2.times { @article.dislike! }
    assert_equal 7, @article.votes
  end

  def test_contain
  end
end
