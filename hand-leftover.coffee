

leftover = (options = {})->
  return (err, req, res, next)->
    return leftover.send500ByOption(req,res, options) if options['500']
    return leftover.send500(err, req, res) if err 
    return leftover.send404ByOption(req,res, options) if options['404']
    return leftover.send404(req,res)

leftover.send500 = (err, req, res)->
  res.statusCode = 500
  res.end('500 - Internal Error')

leftover.send404 = (req,res)->
  res.statusCode = 404
  res.end("404 - Page Not Found")
leftover.send404ByOption = (req,res, options)->
  opt = options['404']
  html = opt.html
  
  res.statusCode = 404
  res.end(html)


module.exports = exports = leftover  
