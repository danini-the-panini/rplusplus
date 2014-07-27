# R++

Making C++ slightly less painful.

Of all the horrid languages to ever exist, C++ has to be the most widely used. R++ aims to being a collection of command-line utilities and magical fairy dust to make all the C++ monsters go away and let you, as the awesome programmer, get to what's important.

R++ also aims to bring some kind of order to the world of C++ by following the principle of convention over configuration.

## Installation

TODO: When it comes out, you'll just have to do this:

    $ gem install rplusplus

## Usage (BIG TODO, NOTHING WORKS YET)

Make a new C++ app, with a Rakefile, .gitignore, and some skeleton source files:

```
$ r++ new MyApp
```

Some other things I plan on including:

Work out the dependencies a-la `g++ -MM`, except in rake-friendly syntax instead of Make:
```
$ r++ -MM some_code.cpp
```

Generates a header and source file skeleton for a class:
```
$ r++ generate class MyClass
```

## Ideas

  * Have `r++` act as a wrapper or superset of `g++` to allow users to drop `r++` straight into an existing project.
  * Add some C++ code generating libraries to use with ERB, and automagically sort out source files with the extension `.cpp.erb`, etc.
  * Make it easy for people to package their library or app or whatever into a deb or an rpm or a pkg or a whatever using a config file called a "libspec" or something (a-la "gemspec").
  * On that note, make it easy for people to publish to a package repository (apt, yum, aur, etc).

## Disclaimer

This has absolutely nothing to do with Bell labs R++.

## I want you to help make R++ better for everyone.

1. Fork it ( https://github.com/[my-github-username]/rplusplus/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
