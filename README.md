### Pre-requisite
- ruby version >= 3 (prefer 3.3.6)

### Test with Rspec
- run `bundle install`
- run `bundle exec rspec .`

### How to run?
There are 2 ways to test the simulator:
- Type the commands in Terminal Console
  ```sh
  ruby simulator.rb
  PLACE 0,0,NORTH
  MOVE
  REPORT

  # enter EXIT or CTRL-C to terminate
  ```

- Provide list of commands in a file
  ```sh
  ruby simulator.rb < commands.txt

  # the application will exit either after proccessed the given file or encounter an EXIT command
  ```
