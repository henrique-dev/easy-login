class BaseService
  attr_accessor :service_object

  def initialize(_args = nil)
    @service_object = ServiceResponse.new
  end

  def self.call(args = nil)
    new.protect(args)
  end

  def protect(args)
    with_service_handler do
      if args.nil?
        call
      elsif args.is_a?(Hash) && args.any?
        call(**args)
      else
        call(args)
      end
    end
  end

  private

  def with_service_handler
    return @service_object unless block_given?

    @service_object.object = yield(@service_object.object)

    @service_object
  rescue Errors::ServiceError => e
    @service_object.success = false
    @service_object.errors.merge!(e.errors)
    @service_object.object = nil
    @service_object
  end
end
