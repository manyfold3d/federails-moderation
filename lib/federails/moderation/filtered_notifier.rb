module Federails::Moderation
  module FilteredNotifier
    extend ActiveSupport::Concern

    included do
      class <<self
        def filter_post_to_inbox(inbox_url:, message:, from: nil)
          filtered_post_to_inbox(inbox_url: inbox_url, message: message, from: from) unless DomainBlock.blocked?(URI.parse(inbox_url).hostname)
        end

        alias_method :filtered_post_to_inbox, :post_to_inbox
        alias_method :post_to_inbox, :filter_post_to_inbox
      end
    end
  end
end
