require "fediverse/inbox"
require "federails/moderation/filtered_inbox"
Fediverse::Inbox.send(:include, Federails::Moderation::FilteredInbox)
