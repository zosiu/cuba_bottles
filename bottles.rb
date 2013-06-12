require "cuba"

Cuba.use Rack::Session::Cookie, :secret => "__a_very_long_string__"

Cuba.define do
  on get do
    on "bottles/:number" do |number|
      number = number.to_i
      bottles = number == 1 ? 'bottle' : 'bottles'
      if number.zero?
        res.write "No more bottles of beer on the wall, no more bottles of beer. :("
      else
        res['Refresh'] = "2, /bottles/#{number-1}"
        res.write "#{number} #{bottles} of beer on the wall, #{number} #{bottles} of beer. Take one down and pass it around ..."
      end
    end

    on root do
      res.redirect "/bottles/99"
    end
  end
end