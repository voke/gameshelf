class API < Grape::API

  version 'v1'
  prefix :api

  get :games do
    {
      'game' => {
        'name' => 'lol'
      }
    }
  end

end
