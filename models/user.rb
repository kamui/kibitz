class User < Sequel::Model
  # include BCrypt
  # include Authorizable
  # include Workflow
  # include WorkflowSequelAdapter

  # one_to_many :clients
  # one_to_many :access_tokens
  # one_to_many :refresh_tokens
  # one_to_many :authorization_codes

  # set_allowed_columns :email, :password

  # workflow_column :state

  # workflow do
  #   state :unconfirmed do
  #     event :confirm, transition_to: :active
  #   end

  #   state :active do
  #     event :deactivate, transition_to: :inactive
  #   end

  #   state :inactive do
  #     event :activate, transition_to: :active
  #   end
  # end

  # def confirm
  #   self.confirmation_token = nil
  #   self.save_changes
  # end

  # subset :unconfirmed, state: "unconfirmed"
  # subset :active, state: "active"
  # subset :inactive, state: "inactive"

  # def self.authenticate(email, unencrypted_password)
  #   email.strip!
  #   user = self[email: email]
  #   user if user && user.password == unencrypted_password && !user.inactive?
  # end

  # def password
  #   @password ||= Password.new(encrypted_password)
  # end

  # def password=(new_password)
  #   @password = Password.create(new_password)
  #   self.encrypted_password = @password
  # end

  # def after_create
  #   super
  #   self.confirmation_token = generate_confirmation_token
  #   self.save_changes
  # end

  # def validate
  #   super
  #   validates_presence [:email, :encrypted_password]
  #   validates_unique :email, :confirmation_token
  # end

  # private
  # def generate_confirmation_token
  #   record = true
  #   while record
  #     token = SecureToken.generate
  #     record = self.class[confirmation_token: token]
  #   end
  #   token
  # end
end