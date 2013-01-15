class String
  def self.colorize(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"
  end

  def red
    self.class.colorize(self, 31);
  end

  def green
    self.class.colorize(self, 32)
  end

  def yellow
    self.class.colorize(self, 33);
  end

  def cyan
    self.class.colorize(self, 36)
  end

  def grey
    self.class.colorize(self, 37);
  end
end
