module Buggerall
  class Resource < ActiveRecord::Base
    attr_accessible :path
    validates :path, presence: true, uniqueness: true
  end
end
