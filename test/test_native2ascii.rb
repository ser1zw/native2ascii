# -*- mode: ruby; coding: utf-8 -*-
require 'test/unit'
require './lib/native2ascii'

class TestNative2Ascii < Test::Unit::TestCase
  def test_str_to_ascii
    assert_equal('\u3042', 'あ'.to_ascii)
    assert_equal('\u3042\u3044\u3046\u3048\u304a', 'あいうえお'.to_ascii)
  end

  def test_str_to_native
    assert_equal('あ', '\u3042'.to_native)
    assert_equal('あいうえお', '\u3042\u3044\u3046\u3048\u304a'.to_native)
  end

  def test_to_ascii
    src = ['# comment 1',
           'aaa=あああ',
           'bbb=いいい # comment 2',
           'ううう',
           'ccc =  えええ'].join("\n")

    expected = ['# comment 1',
                'aaa=\u3042\u3042\u3042',
                'bbb=\u3044\u3044\u3044 # comment 2',
                '\u3046\u3046\u3046',
                'ccc =  \u3048\u3048\u3048'].join("\n")

    assert_equal(expected, Native2Ascii.to_ascii(src))
  end

  def test_to_native
    src = ['# comment 1',
           'aaa=\u3042\u3042\u3042',
           'bbb=\u3044\u3044\u3044 # comment 2',
           '\u3046\u3046\u3046',
           'ccc =  \u3048\u3048\u3048'].join("\n")

    expected = ['# comment 1',
                'aaa=あああ',
                'bbb=いいい # comment 2',
                'ううう',
                'ccc =  えええ'].join("\n")

    assert_equal(expected, Native2Ascii.to_native(src))
  end
end

