Product.destroy_all
Category.destroy_all
ActiveRecord::Base.connection.execute("ALTER SEQUENCE products_id_seq RESTART WITH 1")
ActiveRecord::Base.connection.execute("ALTER SEQUENCE categories_id_seq RESTART WITH 1")

cat1 = Category.create!(title: 'Book')

Product.create!(title: 'SASS Book', description: 'Learn SASS', price: 19.99, published: true, category_id: cat1.id)

p1 = Product.create!(title: 'Ruby Book', description: 'Learn Ruby programming', price: 12.99, published: true)
p2 = Product.create!(title: 'jQuery Book', description: 'Learn jQuery', price: 11.99, published: true)
p3 = Product.create!(title: 'SASS Book', description: 'Learn SASS', price: 19.99, published: true)

cat1.products << p1
cat1.products << p2
cat1.products << p3

puts p1.category.title

cat1.products.each do |p|
    puts p.title
end
