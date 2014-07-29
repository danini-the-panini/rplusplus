# R++

Making C++ slightly less painful.

R++ aims to being a collection of command-line utilities and magical fairy dust to make all the C++ monsters go away and let you, as the awesome programmer, get to what's important.

WARNING: I just started this project so functionality is super limited. You have been warned!

## Installation

    $ gem install rplusplus

## Using it in your Rakefile

In your Rakefile, do this:

```
require 'rplusplus'
env = RPlusPlus::Environment.new
```

Now, env has some useful properties which you can make use of in your Rake tasks:

  * `env.objects` is a hash of the form `'foo.o' => ['foo.cpp', 'foo.h', ...]`
  * `env.builds` is a hash of the form `'main' => ['main.o', 'foo.o', ...]`
  * `env.erbs` is a hash of the form `'foo.cpp' => ['foo.cpp.erb']`

`env.objects` and `env.builds` magically take into account any `*.erb` files in existence so you can just code away without any funny business.

I have used this in one of my own projects and it works like a charm, but I haven't come across any gotchas as of yet so YMMV.

## How does it work?

Object-file dependencies are calculated by going through each cpp file and reading each #include and following it recursively.

The builds are discovered by finding each cpp file with a main function, and then going through each of it's dependencies to build a list of o-files to link.

The ERB dependencies are simply computed by finding each erb file and then removing the erb extention.

Go ahead and crack open that codebase and see for yourself!

## Ideas for the soon-to-exist command-line tool

Make a new C++ app, with a Rakefile, .gitignore, and some skeleton source files:

```
$ r++ new MyApp
```

Generates a header and source file skeleton for a class:
```
$ r++ generate class MyClass
```

## More Ideas

  * Have `r++` act as a wrapper or superset of `g++` to allow users to drop `r++` straight into an existing project.
  * Add some magical C++ code generating libraries to use with ERB.
  * Make it easy for people to package their library or app or whatever into a deb or an rpm or a pkg or a whatever using a config file called a "libspec" or something (a-la "gemspec").
  * On that note, make it easy for people to publish to a package repository (apt, yum, aur, etc).
  * Get a better name perhaps, I don't thing "R++" is the best name for this, since it's already been used by a past, failed project (we might pick up its bad luck or something).

## Disclaimer

This has absolutely nothing to do with Bell labs R++.

## Help me make R++ better for everyone! :)

The easiest way to contribute is to try this thing out and submit an issue when it breaks.

Otherwise if you want to help me implement a super awesome idea then pull requests are easy, fun, and beneficial to all of society:

1. Fork it ( https://github.com/[my-github-username]/rplusplus/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
