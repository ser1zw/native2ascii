# -*- mode: ruby; coding: utf-8 -*-
require 'test/unit'
require './lib/native2ascii'

class TestNative2Ascii < Test::Unit::TestCase
  def setup
    @native_text = ['# comment 1',
                    'aaa=あああ',
                    'bbb=いいい # comment 2',
                    'ううう',
                    'ccc =  えええ',
                    'ddd=<br>おおお<br>'].join("\n")
    @ascii_text = ['# comment 1',
                   'aaa=\u3042\u3042\u3042',
                   'bbb=\u3044\u3044\u3044 # comment 2',
                   '\u3046\u3046\u3046',
                   'ccc =  \u3048\u3048\u3048',
                   'ddd=<br>\u304a\u304a\u304a<br>'].join("\n")
  end

  def test_str_to_ascii
    assert_equal('\u3042', 'あ'.to_ascii)
    assert_equal('\u3042\u3044\u3046\u3048\u304a', 'あいうえお'.to_ascii)

    assert_equal('a', 'a'.to_ascii)
    assert_equal('abcd{}1234', 'abcd{}1234'.to_ascii)
  end

  def test_str_to_native
    assert_equal('あ', '\u3042'.to_native)
    assert_equal('あいうえお', '\u3042\u3044\u3046\u3048\u304a'.to_native)

    assert_equal('a', 'a'.to_native)
    assert_equal('abcd{}1234<asdf>', 'abcd{}1234<asdf>'.to_native)
  end

  def test_to_ascii
    assert_equal(@ascii_text, @native_text.to_ascii)
  end

  def test_to_native
    assert_equal(@native_text, @ascii_text.to_native)
  end
end

