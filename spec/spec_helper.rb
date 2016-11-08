require 'webmock/rspec'

def stub_auth
  stub_request(:post, Twitter::TOKEN_URI)
  .to_return(status: 200, body: json({access_token: 'fake_token'}), headers: {})
end

def json(obj)
  JSON.generate(obj)
end
