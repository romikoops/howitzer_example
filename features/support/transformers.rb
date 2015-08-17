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
define_uniq_entity_transform 'COMMENT'

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

      # UNIQ_COMMENT
      data = /UNIQ_COMMENT(?<num>\d*)(?:\[\:(?<property>.+)\])?/.match(el)
      if data
        res = Gen::given_comment_by_number(data[:num])
        if data[:property]
          res = res.send(data[:property])
        end
      end

      res
    end
  end
  location = Cucumber::Core::Ast::Location.of_caller
  ast_table = Cucumber::Core::Ast::DataTable.new(raw, location)
  Cucumber::MultilineArgument::DataTable.new(ast_table)
end

module Prereq
  class << self
    def given_factory_by_number(factory, num)
      data = DataStorage.extract(factory, num.to_i)
      unless data
        data = FactoryGirl.build(factory)
        DataStorage.store(factory, num.to_i, data)
      end
      data
    end
  end
end

Transform /FACTORY_(\w+)(\d*)(?:\[\:(.+)\])?/ do |factory, num, property|
  res = Prereq::given_factory_by_number(factory.downcase, num)
  res = res.send(property) if property
  res
end

Transform /^table:.*$/ do |table|
  raw = table.raw.map do |array|
    array.map do |el|
      res = el

      data = /FACTORY_(?<factory>\w+)(?<num>\d*)(?:\[\:(?<property>.+)\])?/.match(el)
      if data
        res = Prereq::given_factory_by_number(data[:factory].downcase, data[:num])
        if data[:property]
          res = res.send(data[:property])
        end
      end

      res
    end
  end
  location = Cucumber::Core::Ast::Location.of_caller
  ast_table = Cucumber::Core::Ast::DataTable.new(raw, location)
  Cucumber::MultilineArgument::DataTable.new(ast_table)
end
