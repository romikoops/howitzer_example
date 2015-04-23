#############################################################
#                      TRANSFORMERS                         #
#############################################################
def define_uniq_entity_transform name
  Transform /UNIQ_#{name}(\d*)(?:\[\:(.+)\])?/ do |num, property|
    res = Gen.send("given_#{name.downcase}_by_number", num)
    res = res.send(property) if property
    res
  end
end

define_uniq_entity_transform 'ARTICLE'
define_uniq_entity_transform 'USER'

Transform /^table:.*$/ do |table|
  raw = table.raw.map do |array|
    array.map do |el|
      res = el

      # UNIQ_USER
      data = /UNIQ_USER(?<num>\d*)(?:\[\:(?<property>.+)\])?/.match(el)
      if data
        res = Gen::given_user_by_number(data[:num])
        if data[:property]
          res = res.send(data[:property])
        end
      end

      # UNIQ_ARTICLE
      article = /UNIQ_ARTICLE(?<num>\d*)(?:\[\:(?<property>.+)\])?/.match(el)
      if article
        res = Gen::given_article_by_number(article[:num])
        if article[:property]
          res = res.send(article[:property])
        end
      end

      res
    end
  end
  Cucumber::Ast::Table.new(raw)
end