class FhirServerStub < Sinatra::Base
  set :public_folder, 'data'

  def initialize(app)
    super(app)
  end

  get '/' do
    "<h1>Welcome to FSS</h1>"
  end
end
