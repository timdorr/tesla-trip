namespace :google do
  desc "Gets a route and converts to a JSON array of points"
  task route: :environment do
    response = HTTParty.get(
        "https://maps.googleapis.com/maps/api/directions/json",
        query: {
            key: ENV["GOOGLE_API_KEY"],
            origin: "33.7925,-84.4005", # Start
            waypoints:
                "32.833807,-83.626266|" + # Macon
                "32.135450,-81.212929|" + # Savannah
                "33.486910,-80.475254|" + # Santee
                "34.667303,-79.002466|" + # Lumberton
                "35.973297,-77.847293",   # Rocky Mount
            destination: "37.669021,-77.461619" # Glen Allen
        })

    south = Polylines::Decoder.decode_polyline(response["routes"].first["overview_polyline"]["points"]).map{|coord| [coord[1], coord[0]]}


    response = HTTParty.get(
        "https://maps.googleapis.com/maps/api/directions/json",
        query: {
            key: ENV["GOOGLE_API_KEY"],
            origin: "37.669021,-77.461619", # Glen Allen
            waypoints:
                "38.643325,-77.295840|" + # Woodbridge
                "39.662408,-75.691880|" + # Newark
                "40.195407,-74.640843|" + # Hamilton Township
                "40.548311,-74.333237|" + # Edison
                "40.957429,-74.074080|" + # Paramus
                "41.722672,-72.759717|" + # West Hartford
                "42.203608,-71.832516",   # Auburn
            destination: "42.832,-71.295" # End
        })

    north = Polylines::Decoder.decode_polyline(response["routes"].first["overview_polyline"]["points"]).map { |coord| [coord[1], coord[0]] }

    pp south + north
  end
end
