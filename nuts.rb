#
Camping.goes :Nuts

module Nuts::Controllers
  class Index < R '/'
    def get
      @t = Time.now.to_s
      render :sundial
    end
  end
end

module Nuts::Views
  def layout
    html do
      head do
	title { "Nuts And GORP" }
      end
      body { self << yield }
    end
  end

  def sundial
    p "The current time is: #{@t}"
  end
end
