# README

# Installation

- (RVM was used for this project)
- clone the repository
- `cd bixi_finder/`
- git checkout to the desired branch (explained below)
- run `bundle install`
- run `rake db:drop db:create db:migrate`
- run `rails s -p 3000` (change port as you wish)

# GIT Branches

I created 3 branches:

- `master`: fastest execution time, but does not respect the condition "we shall not parse all stations at each HTTP call". It actually reset the table at each HTTP call and recreate records from the JSON response with a bulk `INSERT` SQL statement (~2200 ms with ActiveRecord's `create` vs. ~25 ms for a single `INSERT` with `bulk_create`, both for 539 BixiStation to create)
- `without_recreating_all_bixi_stations`: heavier to run, refresh BixiStation from JSON feed only when asked, does not store the "variables attributes" (available_bikes, last_checked_at, useable)
- `with_presenters_without_recreating_all_bixi_stations`: same as the previous but with a BixiStationPresenter (less logic in the view)

If you ask me only one branch to be evaluated, I would select the `without_recreating_all_bixi_stations` branch because it matches the conditions provided. The branch with presenters might be "overkill" (the BixiStationPresenter provides only 6 methods) but I wanted to show you how I would reduce the logic in the view and put it in a separated class. I did the `master` branch with a single `INSERT` SQL to demonstrate that it is actually possible to achieve this app and "parse all stations at each HTTP call". On master, development mode, the page takes less than 500 ms to be displayed (Views: ~75ms | ActiveRecord: ~25ms). On the other branches, it takes about the same time to render (~50ms more for the branch with the BixiStationPresenter).