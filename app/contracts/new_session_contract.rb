class NewSessionContract < BaseContract
  params do
    required(:email).filled(:string)
    required(:password).filled(:string)
  end

  rule(:email) do
    unless %r{^[\w!#$%&'*+-/=?^_`{|}~.]{1,64}@[a-zA-Z0-9.-]{1,128}$}.match?(value)
      key.failure('is not valid')
    end
  end

  rule(:password) do
    unless /[0-9]{2}/.match?(value) # at least 2 numbers
      key.failure('must have at least 2 numbers')
    end

    unless %r{[ !"#$%&'()*+,-./:;<=>?@\[\\\]^_`{|}~]{2}}.match?(value) # at least 2 special chars
      key.failure('must have at least 2 special chars')
    end

    unless /[A-Z]{2}/.match?(value) # at least 2 uppercase letters
      key.failure('must have at least 2 uppercase letters')
    end

    unless /[a-z]{2}/.match?(value) # at least 2 lowercase letters
      key.failure('must have at least 2 lowercase letters')
    end
  end

  def transform(key, value)
    return value.downcase if key == 'email'

    value
  end
end
