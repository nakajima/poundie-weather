require "nokogiri"

class PoundieWeather < Poundie::Plugin
  register :poundie_weather

  match do |message|
    puts "checking #{message.body.inspect}"
    message.body =~ /^poundie weather /
  end

  action do |message|
    begin
      place = message.body.gsub(/^poundie weather /, "").strip
      woeid = get_woeid(place)
      doc = Nokogiri(get("http://weather.yahooapis.com/forecastrss?w=#{woeid}"))
      current = get_current(doc)
      forecast = get_forecast(doc)
      paste "#{current["text"]}, #{current["temp"]} F\n#{forecast}"
    rescue => e
      puts e.message
    end
  end

  private

  def get_current(doc)
    Hash[*doc.at('yweather|condition').to_a.flatten]
  end

  def get_forecast(doc)
    doc.search('yweather|forecast').map { |node|
      day = Hash[*node.to_a.flatten]
      "#{day["day"]}, #{day["date"]}: #{day["text"]}, High: #{day["high"]} Low: #{day["low"]}"
    }.join("\n")
  end

  def get_woeid(name)
    speak "Finding place #{name}..."
    name = CGI.escape(name)
    res = get("http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20geo.places%20where%20text%3D%22#{name}%20CA%22&format=xml")
    res.scan(/<woeid>(\d+)<\/woeid>/).to_s
  end
end

Poundie.use :poundie_weather