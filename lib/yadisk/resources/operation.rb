# frozen_string_literal: true

module Yadisk
  class OperationRest < Rest
    def status(operation_id:)
      resp = Operation.new get_request("disk/operations/#{operation_id}").body
      resp.status
    end
  end
end
