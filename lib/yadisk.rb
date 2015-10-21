# TODO: need to be refactored.

class Yadisk
  def initialize
    p "Yadisk init"
  end
  
  def login 
    p "logged in..."
  end
  
  def mkdir (path)
    p "Making #{path}"
  end
  
  def rm (path)
    p "#{path} removed ..."
  end
  
  def get (path)
    p "Getting #{path}"
  end
  
  def put (path)
    p "Putting #{path}"
  end
  
  def exists? (path)
    p "exist || or not"
  end
  
end
