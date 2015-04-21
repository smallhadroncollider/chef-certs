actions :create

def initialize(*args)
  super
  @action = :create
end

attribute :name, :kind_of => String, :name_attribute => true
attribute :certificate, :kind_of => String, :required => true
attribute :key, :kind_of => String, :required => true
