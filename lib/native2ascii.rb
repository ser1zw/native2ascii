# -*- mode: ruby; coding: utf-8 -*-
require 'cgi'

class String
  def to_ascii
    self.split(//).map { |x| '\u' + x.ord.to_s(16) }.join
  end

  def to_native
    self.split('\u').map { |x| x == '' ? '' : x.to_i(16).chr('utf-8') }.join
  end

  def escapeHTML
    CGI.escapeHTML(self).lines.map { |s| s.chomp + '<br/>' }.join
  end
end

class Native2Ascii
  def self.to_ascii(src)
    convert(src) { |value| value.to_ascii }
  end

  def self.to_native(src)
    convert(src) { |value| value.to_native }
  end

  private
  def self.convert(src, &block)
    converted = []
    src.lines.each { |line|
      key = ''
      comment = ''
      value = line.chomp.gsub(/([\w\d\s]+=\s*)/) { |s| key = s; '' }
      value.gsub!(/(\s*#.+)/) { |s| comment = s; '' }
      converted << key + block.call(value) + comment
    }
    converted.join("\n")
  end
end

