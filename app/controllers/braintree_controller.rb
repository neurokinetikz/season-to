class BraintreeController < ApplicationController
  def challenge
  	challenge = request.params["bt_challenge"]
    challenge_response = Braintree::WebhookNotification.verify(challenge)
    return [200, challenge_response]
  end

  def webhook
  	webhook_notification = Braintree::WebhookNotification.parse(request.params["bt_signature"], request.params["bt_payload"])
    puts "[Webhook Received #{webhook_notification.timestamp}] Kind: #{webhook_notification.kind} | Subscription: #{webhook_notification.subscription.id}"
    return 200
  end
end
