require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
=begin
  test "price must be present" do
    product = Product.new(title: "Test Product", description: "A valid description")
    product.price = 1.00
    assert_not product.valid?, "Product should be invalid without a price"
  end

  test "price must be greater than zero" do
    product = Product.new(title: "Test Product", description: "A valid description")
    product.price = -1
    assert_not product.valid?, "Product should be invalid with a negative price"
  end

  test "price is valid with up to two decimal places" do
    product = Product.new(title: "Test Product", description: "A valid description", price: 10.12)
    assert product.valid?, "Product should be valid with a price greater than zero and up to two decimal places"
  end
=end
  test "price must have up to two decimal places" do
    product = Product.new(title: "Test Product", description: "A valid description")
    product.price = 10.123222
    assert product.valid?, "Product should be invalid with more than two decimal places"
  end

=begin
  test "desc is valid with up to 10 words" do
    product = Product.new(title: "Test Product",  price: 10.12)
    product.description = "A validaddddddddddddddddddd"
    assert product.valid?, "El producto debe ser valido con una descripcion de hasta 10 palabras"
  end
=end

  test 'can delete products' do
    assert_difference('Product.count', -1) do
      delete product_path(products(:ps4))
    end

    assert_redirected_to products_path
    assert_equal flash[:notice], 'Tu producto se ha eliminado correctamente'
  end
end