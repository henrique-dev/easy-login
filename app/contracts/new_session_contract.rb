class NewSessionContract < BaseContract
  params do
    required(:email).filled(:string)
    required(:password).filled(:string, min_size?: 10, max_size?: 72)
  end

  rule(:email) do
    unless %r{^[\w!#$%&'*+-/=?^_`{|}~.]{1,64}@[a-zA-Z0-9.-]{1,128}$}.match?(value)
      key.failure('is not valid')
    end
  end

  rule(:password) do
    if value.scan(/[0-9]/).size < 2 # at least 2 numbers
      key.failure('must have at least 2 numbers')
    end

    if value.scan(%r{[ !"#$%&'()*+,-./:;<=>?@\[\\\]^_`{|}~]}).size < 2 # at least 2 special chars
      key.failure('must have at least 2 special chars')
    end

    if value.scan(/[A-Z]/).size < 2 # at least 2 uppercase letters
      key.failure('must have at least 2 uppercase letters')
    end

    if value.scan(/[a-z]/).size < 2 # at least 2 lowercase letters
      key.failure('must have at least 2 lowercase letters')
    end
  end

  def transform(key, value)
    return value.downcase if key == 'email'

    value
  end
end
