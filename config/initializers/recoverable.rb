module Devise
  module Models
    module Recoverable
      protected
        module ClassMethods
          # Attempt to find a user by its reset_password_token to reset its
          # password. If a user is found and token is still valid, reset its password and automatically
          # try saving the record. If not user is found, returns a new user
          # containing an error in reset_password_token attribute.
          # Attributes must contain reset_password_token, password and confirmation
          def reset_password_by_token(attributes={})
            original_token       = attributes[:reset_password_token]
            reset_password_token = Devise.token_generator.digest(self, :reset_password_token, original_token)

            recoverable = find_or_initialize_with_error_by(:reset_password_token, original_token)

            if recoverable.persisted?
              if recoverable.reset_password_period_valid?
                recoverable.reset_password!(attributes[:password], attributes[:password_confirmation])
              else
                recoverable.errors.add(:reset_password_token, :expired)
              end
            end

            recoverable.reset_password_token = original_token
            recoverable
          end
        end
    end
  end
end