class BasicRecord
  include ActiveModel::Model

  @@repository = {}
  @@repository_indexed = {}
  @@next_id = {}

  attr_accessor :id

  class << self
    def inherited(subclass)
      super
      @@repository[subclass.to_s] ||= {}
      @@next_id[subclass.to_s] ||= 0
    end

    def all
      @@repository[name]
    end

    def count
      @@repository[name].count
    end

    def find(id)
      @@repository[name][id]
    end

    def find_by(params)
      record = @@repository[name].find do |_id, user|
        params.all? do |key, value|
          user.instance_variable_get("@#{key}") == value
        end
      end

      record.nil? ? nil : record[1]
    end

    def create(params)
      record = new(params)

      record.save && record
    end
  end

  def save
    if validate
      @id = generate_id
      @@repository[self.class.name] ||= {}
      (@@repository[self.class.name][@id] = self) && true
    else
      false
    end
  end

  def save!
    return unless validate!

    save
  end

  def destroy
    @@repository[self.class.name].delete(id)
  end

  def generate_id
    @@next_id[self.class.name] += 1
  end
end
