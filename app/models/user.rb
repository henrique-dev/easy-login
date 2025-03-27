class User < BasicRecord
  attr_accessor :name, :email, :password

  validates_presence_of :name, :email, :password

  def initialize(params)
    super

    @name = params[:name]
    @email = params[:email]
    @password = params[:password]
  end
end
