# Jabverwock
Experiment; Integrate HTML, CSS, Javascript

## What is the Jabverwock?
Jaberwock is open source project to make web page using Ruby.

That mean "Do not use HTML, CSS, JS (if possible)".


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jabverwock'
```

## How to use

### simple example

export html file, which write on only `<!DOCTYPE html>`

file name is `n` and file path is `~/path`

 ```ruby
 doc = DOCTYPE.new
 doc.pressConfig(name: n, dist: ~/path/)
 doc.press
 ```
> [result]
>> <!DOCTYPE html>


### Press

press command export html ( css, js ) generated by ruby.


+ pressConfig (name: name, dist: path)
	+ 	name: file name
	+ dist: path of file

+ press
	+ press command need pressConfig		


### HTML
---
 ```ruby
 html = html.new
 html.pressConfig(name: n, dist: testPATH)
 html.pressDefalt
 ```
 
>[result]
>> \<HTML>
>> 
>> \</HTML>



## License
Jabverwock is distributed under MIT license.

Copyright (c) 2016 Kazuyuki Shimizu
