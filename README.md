# StockItUp
StockItUp is a web-based stock portfolio app written using Ruby on Rails for the NYC TTP fullstack assessment. It lets a user create a unique account based on email address, 'buy' stocks within a $5000 USD starting budget, and see a list of stocks owned and transactions / trades completed.

![The StockItUp Portfolio page](https://i.imgur.com/u5b6T07.png)

### How to Use
StockItUp was built on Ruby 2.6.3 and uses Bundler to install gem dependencies. You'll probably need a similar set-up to get it to run correctly.

#### Installation
1. First, clone or download this repo.
2. `cd` into the `stock-app` directory in `TTP-FS` and run `bundle install` to install all the required gems.
3. Enter `rake db:migrate` to run the database migrations.
4. Start the rails server by typing `rails server` or `rails s`.

#### Using the app
1. Create an account with name, email, and password.
2. After signing in, you'll land on the Portfolio page.
3. Purchase some shares by entering a valid stock ticker symbol and a whole number of shares.
4. Your purchase will fail if your balance is too low to cover the transaction.
5. Click the Transactions link at the top of the page to see a list of all of your trades.