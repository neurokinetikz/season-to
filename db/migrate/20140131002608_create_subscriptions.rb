class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer   :user_id
      t.integer   :plan_id
      t.string    :state
      t.integer   :billing_day_of_month
      t.datetime  :first_billing_date
      t.datetime  :billing_period_start_date
      t.datetime  :billing_period_end_date
      t.datetime  :paid_through_date
      t.datetime  :next_billing_date
      t.integer   :next_billing_period_amount_cents
      t.integer   :failure_count
      t.timestamps
    end
    
    add_index :subscriptions, :user_id
    add_index :subscriptions, :plan_id
    add_index :subscriptions, :state
    add_index :subscriptions, :billing_day_of_month
  end
end
