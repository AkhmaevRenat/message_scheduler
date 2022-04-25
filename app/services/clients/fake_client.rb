module Clients
  class FakeClient < Base
    def send_message(message:)
      true
    end
  end
end
