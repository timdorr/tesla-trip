namespace :mapbox do
  desc "Grabs all the tiles from Mapbox's servers"
  task :tiles, [:zoom, :yrange, :xrange] => :environment do |t, args|
    args.with_defaults(
        zoom: 6,
        yrange: "11..24",
        xrange: "15..30"
    )

    uri_base = "https://a.tiles.mapbox.com/v4/base.mapbox-streets+bg-e8e0d8_landuse_water_buildings_streets"

    args.yrange.split('..').inject { |s, e| s.to_i..e.to_i }.each do |y|
      args.xrange.split('..').inject { |s, e| s.to_i..e.to_i }.each do |x|
        puts "Saving #{args.zoom}/#{y}/#{x}"
        File.open("#{Rails.root}/public/tiles/#{args.zoom}/#{y}/#{x}.png", "wb") do |f|
          f.write(HTTParty.get("#{uri_base}/#{args.zoom}/#{y}/#{x}.png?access_token=#{ENV["MAPBOX_TOKEN"]}").parsed_response)
        end
        File.open("#{Rails.root}/public/tiles/#{args.zoom}/#{y}/#{x}@2x.png", "wb") do |f|
          f.write(HTTParty.get("#{uri_base}/#{args.zoom}/#{y}/#{x}@2x.png?access_token=#{ENV["MAPBOX_TOKEN"]}").parsed_response)
        end
      end
    end
  end
end
