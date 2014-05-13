request = require 'supertest'


describe 'hand-leftover', ()->

  ho = require 'handover'
  leftover = require '../hand-leftover'
  http = require 'http'


    
  it 'should 404 ', (done)-> 

    server = http.createServer ho.make [
      leftover()
    ]
    request(server)
      .get('/')
      .expect(404) 
      .end done

  it 'should 500 ', (done)-> 
    server = http.createServer ho.make [
      (req,res,next)-> next new Error 'Error : Just Error' 
      leftover()
    ]
    request(server)
      .get('/')
      .expect(500)
      .end done
 
