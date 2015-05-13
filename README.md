# R++ [![Gem Version](https://badge.fury.io/rb/rplusplus.svg)](http://badge.fury.io/rb/rplusplus) [![Circle CI](https://circleci.com/gh/jellymann/rplusplus.svg?style=svg)](https://circleci.com/gh/jellymann/rplusplus) [![Code Climate](https://codeclimate.com/github/jellymann/rplusplus/badges/gpa.svg)](https://codeclimate.com/github/jellymann/rplusplus)

Making C++ slightly less painful.

R++ aims to being a collection of command-line utilities and magical fairy dust to make all the C++ monsters go away and let you, as the awesome programmer, get to what's important.

## Installation

```
$ gem install rplusplus
```

## Usage

### Create a new Project

Make a new C++ app, with a Rakefile, gitignore, and some skeleton source files:

```
$ r++ new MyApp
```

This creates a folder called `MyApp` with a main source file called `my_app.cpp` as well as accompanying `Rakefile` and `.gitignore` files to get you going.

### Class Generator

Generate header and source file skeletons for a class:

```
$ r++ generate class MyClass
```

This generates a `my_class.h` and `my_class.cpp` file in the current directory.

### In your Rakefile

**NOTE**: You still have to do some work yourself in the Rakefile at this point. Grab the example Rakefile in `examples/Rakefile` and modify it to your needs.

At the moment, all R++ can do is calculate the dependencies for you, a la `g++ -MM`. Just add this to your Rakefile:

```ruby
require 'rplusplus'
env = RPlusPlus::Environment.new
```

Now, `env` has some useful properties which you can make use of in your Rake tasks:

  * `env.objects` is a hash of `*.o` files to dependencies: e.g.
    `'foo.o' => ['foo.cpp', 'foo.h', ...]`
  * `env.builds` is a hash of executables to dependencies: e.g.
    `'main' => ['main.o', 'foo.o', ...]`
  * `env.erbs` is a hash of `*.erb` files to dependencies: e.g.
    `'foo.cpp' => ['foo.cpp.erb']`

The `env.objects` and `env.builds` hashes magically take into account any `*.erb` files in existence so you can just code away without any funny business.

## How does it work?

Object-file dependencies are calculated by going through each cpp file and reading each #include and following it recursively.

The builds are discovered by finding each cpp file with a main function, and then going through each of it's dependencies to build a list of o-files to link.

The ERB dependencies are simply computed by finding each erb file and then removing the erb extention.

Go ahead and crack open that codebase and see for yourself!

## Coming Soon

Generate a basic Rakefile, etc. for an existing C++ project:

```
$ r++ init
```

## More Ideas

  * Move all the boilerplate from the example Rakefile into R++ so there is less for developers to do to get started.
  * Add support for a C++ test framework and add a `rake test` task.
  * Do some kind of caching for the dependencies. I'm suspecting the Rakefile will take really long on a larger project.
  * Add some magical C++ code generating libraries to use with ERB.
  * Make it easy for people to package their library or app or whatever into a deb or an rpm or a pkg or a whatever using a config file called a "libspec" or something (a-la "gemspec").
  * On that note, make it easy for people to publish to a package repository (apt, yum, aur, etc).
  * Have `r++` act as a wrapper or superset of `g++` to allow users to drop `r++` straight into an existing project.

## Disclaimer

This has absolutely nothing to do with [Bell labs R++](http://ect.bell-labs.com/who/pfps/rpp/index.html).

## Help make R++ better for everyone :)

The easiest way to contribute is to try this thing out and submit an issue when it breaks.

Otherwise if you want to help me implement a super awesome idea then pull requests are easy, fun, and beneficial to all of society:

1. Fork it ( https://github.com/[my-github-username]/rplusplus/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
