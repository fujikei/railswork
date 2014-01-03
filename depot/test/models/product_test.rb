require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	fixtures :products

  test "product attributes must not be empty" do
  	product = Product.new
  	assert product.invalid?
  	assert product.errors[:title].any?
  	assert product.errors[:description].any?
  	assert product.errors[:price].any?
  	assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
  	product = Product.new(title: "My Book Title",
  		description: "yyy",
  		image_url: "zzz.jpg")
  	product.price = -1
  	assert product.invalid?

  	product.price = 0
  	assert product.invalid?

  	product.price = 1
  	assert product.valid?
  end

  def new_product(image_url)
  	product = Product.new(title: "My Book Title",
  		description: "yyy",
  		price: 1,
  		image_url: image_url)
  end

  test "image url" do
  	ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://aiueo.com/fred.gif}
  	ng = %w{ fred.doc fred.gif/more fred.gif.more aiueo}

  	ok.each do |name|
  		assert new_product(name).valid?, "#{name} shouldn't be invalid"
  	end

  	ng.each do |name|
  		assert new_product(name).invalid?, "#{name} shouldn't be valid"
  	end
  end

  test "product is not valid without a unique title" do
  	product = Product.new(
  		title: products(:ruby).title,
  		description: "yyy",
  		price: 1,
  		image_url: "fred.gif")
  	assert !product.save
  	assert_equal "has already been taken", product.errors[:title].join("; ")
  end

  test "text length of Title must be greater than 10" do
  	product = Product.new(
  		title: "aaaaaaaaa",
  		description: "aaa",
  		price: 1,
  		image_url: "fred.gif")
  	assert product.invalid?
  	assert product.errors[:title].any?
  	puts product.errors[:title]
  end
end
