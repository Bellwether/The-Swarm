account = Account.create(name: 'Bellwether')

travis = { name: 'Travis', email: 'dunn.travis@gmail.com', account: account, password: 'ironman', password_confirmation: 'ironman' }
farhood = { name: 'Farhood', email: 'farhood.basiri@gmail.com', account: account, password: 'ironman', password_confirmation: 'ironman'}
User.create([travis, farhood])