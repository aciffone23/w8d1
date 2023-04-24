require 'rack'



class MyController
    def initialize(req,res)
        @res = res 
        @req = req 
    end

    def render_content(content, content_type = "text/html")
        @res.write(content)
        @res['Content-Type'] = content_type
        nil
    end

    def redirect_to(url)
        @res.status = 302 
        @res["Location"] = url 
        nil 
    end

    def execute 
        if @req.path == "/i/love/app/academy"
            render_content "I love app academy"
        else 
            render_content "Hello World"
        end
    end
end

# def execute 
#     if @res.path == "/i/love/app/academy"
#         res['Content-Type'] = 'text/html'
#         res.write("i love app academy!")
#     end
# end

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  MyController.new(req,res).execute 
  res.finish
end

Rack::Server.start({
  app: app,
  Port: 3000
})
