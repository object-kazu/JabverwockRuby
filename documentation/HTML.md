HTML tags express by class.

# method
## new (level)
Making tag ( = make instance)  
Level is only need in the case of Heading tag (default = 1).  
In other case, level is ignored.  

*__level__* :  int (1 ~ 6), heading level
```ruby
HTML.new
```
>[result]
>>```
>><html>
>></html>
>>```

## content (str)
add content to tag.  
*__str__* : string, tag content
```ruby
   pp = P.new
   pp.content = "Hello world!"

or

   pp = P.new.contentIs "Hello world!"

off course, same.
    hi = "Hello world!"
    pp = P.new.contentIs hi

```
>[result]
>>```html
>>	<p>Hwllow world!</p>
>>```

## addChild (elem)
*__elem__* : element, add child element.

```ruby
head = HEAD.new
html.addChild head
```
>[result]
>>```html
>>	<html>
>>		<head>
>>		</head>
>>	</html>
>>```


## addChildren (*elem)
*__*elem__* : array, adding some elements.

```ruby
head = HEAD.new
body = BODY.new
html.addChildren head, body

```
>[result]
>>```html
>>	<html>
>>		<head>
>>		</head>
>>		<body>
>>		</body>
>>	</html>
>>```



 ```ruby
  $PAGES =  %w(home about contact)

  def self.header
    head = HEAD.new
    
    title = TITLE.new
    title.content = "This is my first page"
    head.addChild title

    head
  end

  def self.aList    
    arr = []
    $PAGES.each do |a|
      tdash = "www:" << a
      t = A.new.contentIs(a.capitalize).attr(:href, tdash)
      arr << t
    end
    arr
  end
  
  def self.bodier
    body = BODY.new    
    heading = HEADING.new(1).contentIs 'This is addChildren test'
    
    body.addChild heading
    body.addChildren aList    
    body
  end
  
  html= HTML.new
  html.addChildren header, bodier

 ```
>[result]
>>```
>><html>
>>   <head>
>>     <title>This is my first page</title>
>>   </head>
>>   <body>
>>     <h1>This is addChildren test</h1>
>>     <a href="www:home">Home</a>
>>     <a href="www:about">About</a>
>>     <a href="www:contact">Contact</a>	
>>    </body>
>></html>
>>```

## addMember (elem)
*__elem__* : element, add it as member.

```ruby
   html.addMember head
```
>[result]
>>```html
>>	<html>
>>	</html>
>>	<head>
>>	</head>
>>```

## addMembers (*elem)
*__elem__* : adding some elements.

```ruby
head = HEAD.new
body = BODY.new
html.addMembers head, body

or

html.addMembers [head, body]
```
>[result]
>>```html
>>	<html>
>>	</html>
>>	<head>
>>	</head>
>>	<body>
>>	</body>
>>```

## tgStr
HTML tag class can export as string.
you want to write case of tag in tag.

 ```ruby
bold = B.new.contentIs "test"

pp = P.new.contentIs "This is #{bold.tgStr}"
body.addChild pp
 ```
>[result]
>>```
>><p>This is <b>test</b></p>
>>```

another case, 

 ```ruby
  
  a = A.new.contentIs("test").attr(:href,"www://")
  pp = P.new.contentIs "What is this? #{a.tgStr}"

  body = BODY.new
  body.addChild pp

  html= HTML.new  
  html.addChild body

 ```
>[result]
>>```
>><html>
>>	<body>
>>		<p>What is this? <a href="www://">test</a></p>
>>	</body>
>></html>
>>```


# Class
## Heading
`<h1> ~ <h6>`  
heading tag can use argument for the level.

```ruby
html= HTML.new

body = BODY.new
h1 = HEADING.new.contentIs "Hello world!"
h2 = HEADING.new(2).contentIs "See you again"

body.addChildren h1,h2
html.addChild body
```
>[result]
>>```html
>><html>
>>    <body>
>>	<h1>Hello world!</h1>
>>	<h2>See you again</h2>
>>    </body>
>></html>
>>```

## Break
`<br>`  
you can insert break tag by two way.  
one is use Class (tgStr), another is string (Global constant, $BR).

 ```ruby
br = BR.new
p1 = P.new.contentIs "this is " << br.tgStr << "br class"
p2 = P.new.contentIs "this is #{$BR}br string"

body.addChildren p1, p2
 ```
>[result]
>>```html
>><p>this is <br>br class</p>
>><p>this is <br>br string</p>
>>```

br tag sometimes need for end of tag.  
withBreak method is useful.

 ```ruby
p3 = P.new.contentIs("this is last").withBreak
 ```
>[result]
>>```
>><p>this is last</p><br>
>>```


br tag also has content.  

```ruby
br = BR.new.contentIs "this is test"
 ```
>[result]
>>```
>> this is test<br>
>>```