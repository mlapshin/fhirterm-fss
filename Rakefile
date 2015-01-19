DATA_URLS = {
  valuesets: "http://www.hl7.org/implement/standards/FHIR-Develop/valuesets.json"
}

namespace :data do
  task :update do
    require 'rest_client'
    require 'json'

    response = RestClient.get DATA_URLS[:valuesets]
    JSON.parse(response.to_str)["entry"].each do |r|
      vs = r["resource"]
      fn = "data/ValueSet/#{vs['id']}"
      puts "Writing file #{fn}"

      File.open(fn, 'w') { |f| f.write JSON.generate(vs) }
    end

  end
end
