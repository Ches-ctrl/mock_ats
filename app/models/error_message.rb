class ErrorMessage < ApplicationRecord
  validates_presence_of :reference, :message

  def self.message_for(reference)
    ErrorMessage.find_by(reference: reference)&.message || 'Error'
  end
end
