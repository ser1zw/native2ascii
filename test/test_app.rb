# -*- mode: ruby; coding: utf-8 -*-
require 'sinatra'
require 'test/unit'
require 'rack/test'
require 'json'
require './app'

ENV['RACK_ENV'] = 'test'
set :root, File.dirname(__FILE__) + '/..'

class AppTest < Test::Unit::TestCase
  include Rack::Test::Methods

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

  def app
    Sinatra::Application
  end

  def test_index
    get '/'
    assert(last_response.ok?)
    title = last_response.body.scan(/<title>([^<]+)<\/title>/).flatten.first
    assert_equal('Native2Ascii', title)
  end

  def test_convert
    post '/api/convert', mode: 'native2ascii', text: @native_text, escape: false
    assert(last_response.ok?)
    text = JSON.parse(last_response.body)['text']
    assert_equal(@ascii_text, text)
  end

  def test_convert_reverse
    post '/api/convert', mode: 'ascii2native', text: @ascii_text, escape: false
    assert(last_response.ok?)
    text = JSON.parse(last_response.body)['text']
    assert_equal(@native_text, text)
  end
end
