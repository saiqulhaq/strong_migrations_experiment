class User < ApplicationRecord
  self.ignored_columns = [:column_x, :column_ya]
end
