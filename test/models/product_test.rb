require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "should have a positive price" do
    product = products(:one)
    product.price = -1
    assert_not product.valid?
  end

  test "should filter products by name" do
    assert_equal 2, Product.filter_by_title("monitor").count
  end

  test "should filter products by name and sort them" do
    assert_equal [ products(:another_monitor), products(:one) ],
    Product.filter_by_title("monitor").sort
  end

  test "should filter products by price and sort them" do
    assert_equal [ products(:another_monitor), products(:one) ],
    Product.above_or_equal_to_price(800).sort
  end

  test "should filter products by price lower and sort them" do
    assert_equal [ products(:two) ],
    Product.lower_or_equal_to_price(600).sort
  end

  test "should sort product by most recent" do
    products(:two).touch
    assert_equal [products(:another_monitor), products(:one), products(:two)],
    Product.recent.to_a
  end
end
