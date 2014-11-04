require 'minitest/autorun'
require './example'

class ArticleTest < Minitest::Test
  def setup
    @article = Article.new('title', 'body', 'author')
  end

  def test_initialization
    assert_equal 'title', @article.title
    assert_equal 'body', @article.body
    assert_equal 'author', @article.author
    assert_in_delta Time.now, @article.created_at
    assert_equal 0, @article.likes
    assert_equal 0, @article.dislikes
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

  def test_long_lines_when
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

  def test_contain_when_word_is_a_string
  end
end
