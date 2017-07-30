class User < ApplicationRecord
  def location
    return [self.latitude, self.longitude]
  end
end
