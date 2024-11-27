require "federails/moderation/version"
require "federails/moderation/engine"

module Federails
  module Moderation
    def self.table_name_prefix
      "federails_moderation_"
    end
  end
end
