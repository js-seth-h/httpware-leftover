# hand-leftover

> At the end of call chain, it send 404 or 500(when error exists).
> responsed html is customizable.
> written by coffeescript

## Features

* developer takes permission to control 404 / 500 response
* prevent `no answer` from http server 
* compatible with connect


# Why made this?

[handover][ho] is fully compatible with connect's middleware.
So, first my attempt is using [errorhandler][eh].
but, in [errorhandler][eh] , 404(page not found) is also `Error` ( it means I have to throw `new Error '...'`)

[ho]: https://www.npmjs.org/package/handover
[eh]: https://www.npmjs.org/package/errorhandler

My opinion about 404 is differnt.
`Page not found` is naturally occured when all middleware didn't process request.

I need more flexible one.


## Example

 ```coffee 

    server = http.createServer ho.make [
#      ... something you need
      leftover()
    ]
 

 ```
basic usages.

 ```coffee 

    server = http.createServer ho.make [
#      ... something you need
      leftover
        '404':
          html: "<h1> Page Not Found </h1>"
    ]

 ```
static html text is possible.


 ```coffee  

    server = http.createServer ho.make [
#      ... something you need
      leftover
        '404' :
          html: (callback)-> callback 'callback'
    ]

 ```
function is possible too.

```coffee
    server = http.createServer ho.make [
      (req,res,next)-> next new Error 'Just Error' 
      leftover
        '500' :
          html: '500'
    ] 
# or 
    server = http.createServer ho.make [
      (req,res,next)-> next new Error 'Just Error' 
      leftover
        '500' :
          html: (error, callback)-> callback error.toString()
    ]

```

with error handler, it is also possible using text or function.




## License

(The MIT License)

Copyright (c) 2014 junsik &lt;js@seth.h@google.com&gt;

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

 