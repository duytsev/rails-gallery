FactoryGirl.define do
  factory :category do
    name 'Category string'
    ctype {Category.types[:string]}
  end
end
