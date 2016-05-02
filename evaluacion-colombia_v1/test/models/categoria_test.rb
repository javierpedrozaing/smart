require 'test_helper'

class CategoriaTest < ActiveSupport::TestCase
  test "data exists" do
    assert Categoria.find_by(id: 1)
  end
end
