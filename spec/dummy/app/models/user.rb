class User < ApplicationRecord
  include Federails::Entity

  acts_as_federails_actor username_field: :id, name_field: :id
end
