# -*- mode: ruby; coding: utf-8 -*-

class String
  def to_ascii
    self.split(//).map { |x| x.bytesize > 1 ? '\u' + x.ord.to_s(16) : x }.join
  end

  def to_native
    data = self.split(//)
    native = ''
    while c = data.shift
      if c == "\\" and data[0].downcase == 'u'
        # Multi byte charactor found
        data.shift # Delete 'u'
        native << data.shift(4).join.to_i(16).chr('utf-8')
      else
        # Single byte charactor
        native << c
      end
    end
    native
  end
end

