# frozen_string_literal: true

require 'abbrev'
require 'test/unit'
require 'rbs/unit_test'

class AbbrevSingletonTest < Test::Unit::TestCase
  include RBS::UnitTest::TypeAssertions

  library 'abbrev'
  testing "singleton(::Abbrev)"

  def test_abbrev
    assert_send_type '(Array[String]) -> Hash[String, String]',
                     Abbrev, :abbrev, %w[car cone]
    assert_send_type '(Array[String], Regexp) -> Hash[String, String]',
                     Abbrev, :abbrev, %w{car box cone crab}, /b/
    assert_send_type '(Array[String], String) -> Hash[String, String]',
                     Abbrev, :abbrev, %w{car box cone}, 'ca'
  end
end

class AbbrevArrayInstanceTest < Test::Unit::TestCase
  include RBS::UnitTest::TypeAssertions

  library 'abbrev'
  testing "::Array[String]"

  def test_array
    assert_send_type '() -> Hash[String, String]',
                     %w{ car cone }, :abbrev
    assert_send_type '(Regexp) -> Hash[String, String]',
                     %w{ fast boat day }, :abbrev, /^.a/
  end
end
