class BraintreeController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def challenge
    render :text => Braintree::WebhookNotification.verify(params[:bt_challenge])
  end

  def webhook
  	webhook_notification = Braintree::WebhookNotification.parse(params[:bt_signature], params[:bt_payload])
    puts "[Webhook Received #{webhook_notification.timestamp}] Kind: #{webhook_notification.kind} | Subscription: #{webhook_notification.subscription.id}"
    puts "#{webhook_notification.subscription}"
    puts "#{webhook_notification.subscription.transactions}"

    case webhook_notification.kind
    when 'subscription_charged_successfully'
    when 'subscription_charged_unsuccessfully'
    when 'subscription_went_active'
    when 'subscription_went_past_due'
    when 'subscription_canceled'
    when 'subscription_expired'
    else
    end
    
    render nothing: true, status: 200
  end
end