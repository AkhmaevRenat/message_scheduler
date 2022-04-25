module Clients
  class Error < StandardError; end

  class Base
    def send_message(message:)
      raise NotImplementedError
    end
  end
end
