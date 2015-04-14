#############################################################
#                      TRANSFORMERS                         #
#############################################################
Transform /UNIQ_USER(\d*)(?:\[\:(.+)\])?/ do |num, property|
  res = Gen::given_user_by_number(num)
  res = res.send(property) if property
  res
end

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

      res
    end
  end
  Cucumber::Ast::Table.new(raw)
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

      data = /FACTORY_USER(?<factory>\w+)(?<num>\d*)(?:\[\:(?<property>.+)\])?/.match(el)
      if data
        res = Prereq::given_factory_by_number(data[:factory].downcase, data[:num])
        if data[:property]
          res = res.send(data[:property])
        end
      end

      res
    end
  end
  Cucumber::Ast::Table.new(raw)
end
