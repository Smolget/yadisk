class Yadisk
  def self.init
    p "Yadisk init"
  end
  
  def self.login 
    p "logged in..."
  end
  
  def self.mkdir (path)
    p "Making #{path}"
  end
  
  def self.rm (path)
    p "#{path} removed ..."
  end
  
  def self.get (path)
    p "Getting #{path}"
  end
  
  def self.put (path)
    p "Putting #{path}"
  end
  
  def exists? (path)
    p "exist || or not"
  end
  
end
