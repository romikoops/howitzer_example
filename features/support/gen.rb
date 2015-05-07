module Gen
  class << self

    def article(params={})
      prefix = serial
      default = {
          title: gen_article_title(prefix),
          text: gen_article_text(prefix),
      }
      Article.new(default.merge(params))
    end

    def gen_article_title(serial=nil)
      gen_entity('article_title', serial)
    end

    def gen_article_text(serial=nil)
      gen_entity('article_text', serial*7)
    end

    class Article
      attr_reader :title, :text, :creation_time

      def initialize(params={})
        @title = params.delete(:title)
        @text = params.delete(:text)
        @creation_time = "#{Time.now.utc.hour+1}#{Time.now.utc.strftime ':%M'}"
      end
    end

    def given_article_by_number(num)
      data = DataStorage.extract('article', num.to_i)
      unless data
        data = Gen::article
        DataStorage.store('article', num.to_i, data)
      end
      data
    end

  end
end
