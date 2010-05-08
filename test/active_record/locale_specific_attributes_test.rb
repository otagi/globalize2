require File.expand_path(File.dirname(__FILE__) + '/../test_helper')
require File.expand_path(File.dirname(__FILE__) + '/../data/models')

class LocaleSpecificAttributesTest < ActiveSupport::TestCase
  def setup
    I18n.locale = :en
    reset_db!
    ActiveRecord::Base.locale = nil
  end

  test "locale specific writers" do
    post = Post.create(:subject_en => "en subject", :content_en => "en content",
                       :subject_en_us => "en-US subject", :content_en_us => "en-US content",
                       :subject_de => "de subject", :content_de => "de content")

    assert_equal 3, PostTranslation.count

    I18n.locale = :'en-US'
    assert_equal 'en-US subject', post.subject

    I18n.locale = :en
    assert_equal 'en subject', post.subject

    I18n.locale = :de
    assert_equal 'de subject', post.subject

    I18n.locale = :'de-DE'
    # TODO: Assuming no fallbacks here.  Test suite needs a way to test with or without fallbacks
    assert_nil post.subject
  end

  test "locale specific readers" do
    post = Post.create(:subject_en => "en subject", :content_en => "en content",
                       :subject_en_us => "en-US subject", :content_en_us => "en-US content",
                       :subject_de => "de subject", :content_de => "de content")
    post.reload

    assert_equal 'en-US subject', post.subject_en_us
    assert_equal 'en subject', post.subject_en
    assert_equal 'de subject', post.subject_de
    assert_nil post.subject_es
  end

  test "locale specific readers dont use fallbacks" do
    post = Post.create(:subject_en => "en subject", :content_en => "en content",
                       :subject_de => "de subject", :content_de => "de content")
    post.reload

    # TODO: Enable this with fallbacks detection
    if I18n.respond_to?(:fallbacks)
      I18n.locale = :'en-US'
      assert_equal 'en subject', post.subject
      assert_nil post.subject_en_us
    end
  end
end