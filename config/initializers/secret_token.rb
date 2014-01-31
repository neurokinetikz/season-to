# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
SubscriptionService::Application.config.secret_key_base = 'b5aa3c6f48cdb170b83db5d61f63bf568c49c041a8f675da9748958f9b140d844f0254f728e0a40242b5bc299570d9573470c101245dfae58afd29526abc30aa'
