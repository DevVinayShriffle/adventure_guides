class CustomError < StandardError
  attr_reader :status

  def initialize(message = nil, status = :unprocessable_entity)
    @status = status
    super(message)
  end
end