class User < BasicRecord
  attr_accessor :name, :email, :password, :salt

  validates_presence_of :name, :email, :password

  def initialize(params)
    super

    params = HashWithIndifferentAccess.new(params)

    @name = params[:name]
    @email = params[:email]

    return unless params[:password].present?

    @salt = SecureRandom.hex(16)
    @password = Digest::SHA256.hexdigest(salt + params[:password])
  end
end
