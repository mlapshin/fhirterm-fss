# encoding: utf-8
require "sinatra/base"
require "sinatra/reloader"
require 'json'

class FhirServerStub < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    set :show_exceptions, false
  end

  def initialize(app)
    super(app)

    @value_sets = read_resources('value_sets')
    @concept_maps = read_resources('concept_maps')
  end

  before do
    content_type :json
  end

  get '/ValueSet/:id' do
    respond_with_json_or_not_found @value_sets[params[:id]]
  end

  get '/ConceptMap/:id' do
    respond_with_json_or_not_found @concept_maps[params[:id]]
  end

  post '/ValueSet' do
    resource = JSON.parse(request.body.read)
    raise RuntimeException, "No id in resource" unless resource["id"]

    @value_sets[resource["id"]] = resource

    [201, {
       "resourceType" => "OperationOutcome",
       "text" => "OK"
     }.to_json]
  end

  private

  def read_resources(dir)
    path = File.join(File.dirname(__FILE__), "data", dir, "*.json")

    Dir[path].reduce({}) do |result, f|
      content = JSON.parse(File.read(f))

      result.merge! content.reduce({}) { |acc, r| acc[r["id"]] = r; acc }
    end
  end

  def respond_with_json_or_not_found(json)
    if json
      JSON.pretty_generate(json)
    else
      [404,
       {
         "resourceType" => "OperationOutcome",
         "text" => "No data found"
       }.to_json]
    end
  end
end
