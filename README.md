# Logger

Logger is a simple ruby program to analyze request log files, Its purpose is to list out most viewed web pages

# Developer Guide

### Prerequisite

1. Ruby 2.7.x
2. bundle 2.1.x

### Setup

```powershell
bin/setup
```

# GettingStarted

### Console

```powershell
bin/console
```
```ruby
LogProcessor.new(File.open('spec/fixtures/webserver.log', 'r')).process
```

### Output
```ruby
List of webpages with most page views ordered from most pages views to less page views
"/about/                        92 visits"
"/contact                       89 visits"
"/index                         82 visits"
"/about                         81 visits"
"/help_page/                    80 visits"
"/home                          78 visits"
List of webpages with most unique page views ordered from most pages views to less page views
"/about/2                       90 visits"
"/contact                       89 visits"
"/index                         82 visits"
"/about                         81 visits"
"/help_page/1                   80 visits"
"/home                          78 visits"
"/about/3                       1 visits"
"/about/4                       1 visits"
```

### Test cases

```powershell
bundle exec rspec spec/

# Output
Finished in 0.06133 seconds (files took 0.10221 seconds to load)
26 examples, 0 failures
```


### Directory Structure

```sh
├─ lib
  ├─ log_processors
    ├─ analyzer.rb
    ├─ base.rb
    ├─ parser.rb
  ├─ log_processor
├─ spec
```

- **lib** - The home of extended modules, it organizes and directory holds the components of our app, It's got subdirectories that hold the parser and analyzer classes
- **app/base** - It's the base class that inherited by analyzer and parser it has the common shared methods
- **app/analyzer** - This class will analyze our report and will get the response as JSON this class has been used/called by LogProcessor class
- **app/parser** - It's responsibility is to parse the log file and return array of hashes
- **log_processor** - It's acting as an interface for the program user, This class accepts a file as an argument and prints out the analyze logs
- **spec** - Well knowing directory :wink:, It's the power of TDD! You'll see subdirectory unit tests, fixtures, helpers, etc