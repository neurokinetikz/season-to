# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.filter_parameters += [:password, :credit_card, :authenticity_token, :bt_signature, :bt_payload]
