return if User.exists? || Post.exists?

# Setup test users
gerald = User.create!(first_name: 'Gerald', last_name: 'Celanji', email: 'gerald@email.com', birth_date: '1990-01-01', password: 'password')
john   = User.create!(first_name: 'John', last_name: 'Doe', email: 'john@email.com', birth_date: '1990-01-01', password: 'password')
jane   = User.create!(first_name: 'Jane', last_name: 'Doe', email: 'jane@email.com', birth_date: '1990-01-01', password: 'password')
# Setup test posts
Post.create!(content: 'This is the first post.',  user: gerald)
Post.create!(content: 'This is the second post.', user: gerald)
Post.create!(content: 'This is the third post.',  user: john)
Post.create!(content: 'This is the fourth post.', user: jane)
