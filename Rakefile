DATA_URLS = {
  valuesets: "http://www.hl7.org/implement/standards/FHIR-Develop/valuesets.json",
  v2: "http://www.hl7.org/implement/standards/FHIR-Develop/v2-tables.json",
  v3: "http://www.hl7.org/implement/standards/FHIR-Develop/v3-codesystems.json",
  conceptmaps: "http://www.hl7.org/implement/standards/FHIR-Develop/conceptmaps.json"
}

namespace :data do
  task :update do
    require 'rest_client'
    require 'json'

    bundle_to_file(DATA_URLS[:valuesets],
                   "data/value_sets/standard.json")

    bundle_to_file(DATA_URLS[:v2],
                   "data/value_sets/v2.json")

    bundle_to_file(DATA_URLS[:v3],
                   "data/value_sets/v3.json")

    bundle_to_file(DATA_URLS[:conceptmaps],
                   "data/concept_maps/standard.json")
  end

  def bundle_to_file(url, file)
    puts "GET #{url} => #{file}"
    response = RestClient.get url

    resources = JSON.parse(response.to_str)["entry"].map { |r| r["resource"] }
    File.open(file, 'w') do |f|
      f.write JSON.pretty_generate(resources)
    end
  end
end
