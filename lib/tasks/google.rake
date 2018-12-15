namespace :google do
  desc "Gets a route and converts to a JSON array of points"
  task route: :environment do
    response = HTTParty.get(
        "https://maps.googleapis.com/maps/api/directions/json",
        query: {
            key: ENV["GOOGLE_API_KEY"],
            origin: "33.9800,-84.4695", # Start
            waypoints:
                "34.825893,-82.306952|" + # Greenville
                "35.340750,-80.765790|" + # Charlotte
                "36.070788,-79.511222|" + # Burlington
                "36.748516,-78.103517|" +  # South Hill
                "37.669021,-77.461619", # Glen Allen
            destination: "38.774354, -77.177591" # Springfield
            # destination: "37.669021,-77.461619" # Glen Allen
        })

    # south = Polylines::Decoder.decode_polyline(response["routes"].first["overview_polyline"]["points"]).map{|coord| [coord[1], coord[0]]}
    south = response["routes"].first["legs"].map{ |leg| leg["steps"]} .flatten.map{ |step| Polylines::Decoder.decode_polyline(step["polyline"]["points"])} .flatten(1).map{ |coord| { x: coord[1], y: coord[0] }}

    response = HTTParty.get(
        "https://maps.googleapis.com/maps/api/directions/json",
        query: {
            key: ENV["GOOGLE_API_KEY"],
            # origin: "37.669021,-77.461619", # Glen Allen
            origin: "38.774354, -77.177591", # Springfield
            waypoints:
                # "38.643325,-77.295840|" + # Woodbridge
                "39.662408,-75.691880|" + # Newark
                # "40.195407,-74.640843|" + # Hamilton Township
                # "40.322440,-74.486900|" + # Cranberry
                "40.415938,-74.444713|" + # East Brunswick
                # "40.548311,-74.333237|" + # Edison
                # "40.957429,-74.074080|" + # Paramus
                # "41.068167,-73.504659|" + # Darien
                "41.041538,-73.671661|" + # Greenwich
                # "41.722672,-72.759717|" +  # West Hartford
                "42.203608,-71.832516",   # Auburn
            destination: "42.832,-71.295" # End
        })

    # north = Polylines::Decoder.decode_polyline(response["routes"].first["overview_polyline"]["points"]).map { |coord| [coord[1], coord[0]] }
    north = response["routes"].first["legs"].map{ |leg| leg["steps"]} .flatten.map{ |step| Polylines::Decoder.decode_polyline(step["polyline"]["points"])} .flatten(1).map{ |coord| { x: coord[1], y: coord[0] }}

    pp (SimplifyRb::Simplifier.new.process(south, 0.0001, true) +
        SimplifyRb::Simplifier.new.process(north, 0.0001, true)).map{ |coord| [coord[:x], coord[:y]] }
  end
end
