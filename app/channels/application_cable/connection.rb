# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :uuid

    def Connect
      self.uuid = SecureRandom.uuid
    end

  end
end
