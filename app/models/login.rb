class Login
  include ActiveModel::Validations
  extend ActiveModel::Naming
  
  attr_accessor :email, :password
  validates_presence_of :email, :password

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def to_model
    self
  end
  
  def to_key; end
  def to_param; end
  
  def persisted?
    false
  end  
end