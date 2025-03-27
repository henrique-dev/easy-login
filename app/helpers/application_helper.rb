module ApplicationHelper
  def field_with_error(errors, key)
    return [] if errors.nil?

    errors = HashWithIndifferentAccess.new(errors)

    return [] if errors[key].nil?

    errors[key]
  end
end
