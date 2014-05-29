request = require 'supertest'


describe 'httpware-leftover', ()->

  flyway = require 'flyway'
  leftover = require '../src'
  http = require 'http'


    
  it 'should 404 ', (done)-> 

    server = http.createServer flyway [
#      ... something you need
      leftover()
    ]
    request(server)
      .get('/')
      .expect(404) 
      .end done 

  it 'should 500 ', (done)-> 
    server = http.createServer flyway [
#      ... something you need
      (req,res,next)-> next new Error 'Just Error' 
      leftover()
    ]
    request(server)
      .get('/')
      .expect(500)
      .expect(/.*Just Error.*/)
      .end done 

  it 'should 404 with text', (done)-> 

    server = http.createServer flyway [
#      ... something you need
      leftover
        '404':
          html: "<h1> Page Not Found </h1>"
    ]
    request(server)
      .get('/')
      .expect(404) 
      .expect(/.*h1.*/)
      .end done

    
  it 'should 404 with function', (done)-> 

    server = http.createServer flyway [
#      ... something you need
      leftover
        '404' :
          html: (callback)-> callback 'callback'
    ]
    request(server)
      .get('/')
      .expect(404) 
      .expect('callback')
      .end done

  it 'should 500 with text ', (done)-> 

    server = http.createServer flyway [
      (req,res,next)-> next new Error 'Just Error' 
      leftover
        '500' :
          html: '500'
    ]
    request(server)
      .get('/')
      .expect(500) 
      .expect('500')
      .end done
  it 'should 500 with function ', (done)-> 

    server = http.createServer flyway [
      (req,res,next)-> next new Error 'Just Error' 
      leftover
        '500' :
          html: (error, callback)-> callback error.toString()
    ]
    request(server)
      .get('/')
      .expect(500) 
      .expect('Error: Just Error')
      .end done