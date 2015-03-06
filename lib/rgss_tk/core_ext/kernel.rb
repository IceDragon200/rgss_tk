require 'rgss_tk/rvdata'

module Kernel
  def load_data(filename)
    Rvdata.load_file(filename)
  end

  def save_data(obj, filename)
    Rvdata.save_file(filename, obj)
  end
end
