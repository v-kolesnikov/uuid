# Author:: Assaf Arkin  assaf@labnotes.org
#          Eric Hodel drbrain@segment7.net
# Copyright:: Copyright (c) 2005-2008 Assaf Arkin, Eric Hodel
# License:: MIT and/or Creative Commons Attribution-ShareAlike

require 'test/unit'
require 'uuid'

class TestUUID < Test::Unit::TestCase

  def test_generate
    uuid = UUID.new
    assert_match(/\A[\da-f]{32}\z/i, uuid.generate(:compact))

    assert_match(/\A[\da-f]{8}-[\da-f]{4}-[\da-f]{4}-[\da-f]{4}-[\da-f]{12}\z/i,
                 uuid.generate(:default))

    assert_match(/^urn:uuid:[\da-f]{8}-[\da-f]{4}-[\da-f]{4}-[\da-f]{4}-[\da-f]{12}\z/i,
                 uuid.generate(:urn))

    e = assert_raise ArgumentError do
      uuid.generate :unknown
    end

    assert_equal 'invalid UUID format :unknown', e.message
  end

  def test_monotonic
    seen = {}
    uuid_gen = UUID.new

    20_000.times do
      uuid = uuid_gen.generate
      assert !seen.has_key?(uuid), "UUID repeated"
      seen[uuid] = true
    end
  end

end
