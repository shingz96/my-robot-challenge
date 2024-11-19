require 'logger'

module Toy
  module Logable
    def logger_name
      raise NotImplementedError, 'You must implement logger_name'
    end

    def logger
      @logger ||= Logger.new("logs/#{logger_name}.log")
    end

    def log_error(error)
      logger.error(error.message)
      logger.error(error.backtrace.join("\n"))
    end
  end
end
