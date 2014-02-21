class BraintreeController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def challenge
    render :text => Braintree::WebhookNotification.verify(params[:bt_challenge])
  end

  def webhook
  	webhook_notification = Braintree::WebhookNotification.parse(params[:bt_signature], params[:bt_payload])
    puts "[Webhook Received #{webhook_notification.timestamp}] Kind: #{webhook_notification.kind} | Subscription: #{webhook_notification.subscription.id}"
    render status: 200
  end
end
