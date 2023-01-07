require_relative "test_helper"

class StartAfterTest < Minitest::Test
  def test_version_safe
    with_start_after(20170101000001) do
      assert_safe Version
    end
  end

  def test_version_unsafe
    with_start_after(20170101000000) do
      assert_unsafe Version
    end
  end

  def with_start_after(start_after)
    StrongMigrations.stub(:start_after, start_after) do
      yield
    end
  end
end
