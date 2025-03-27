class User < BasicRecord
  attr_accessor :name, :email, :password, :crypted_password, :salt

  validates_presence_of :name, :email

  def initialize(params = {})
    super
    params = HashWithIndifferentAccess.new(params)

    @name = params[:name]
    @email = params[:email]
    @password = params[:password]
  end

  def authenticate(password_to_check)
    Digest::SHA256.hexdigest(salt + password_to_check) == crypted_password
  end

  def save
    return unless @password.present?

    @salt = SecureRandom.hex(16)
    @crypted_password = Digest::SHA256.hexdigest(salt + @password)
    @password = nil

    super
  end
end
