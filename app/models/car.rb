class Car < ActiveRecord::Base
  belongs_to :owner, class_name: 'Person'
end
