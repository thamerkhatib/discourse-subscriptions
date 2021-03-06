# frozen_string_literal: true

class PaymentSerializer < ApplicationSerializer
  attributes  :payment_intent_id,
              :receipt_email,
              :url,
              :created_at_age,
              :amount,
              :amount_currency,
              :username,
              :user_id

  def created_at_age
    Time.now - object.created_at
  end

  def amount_currency
    ActiveSupport::NumberHelper.number_to_currency(
      object.amount / 100,
      precision: 2,
      unit: currency_unit
    )
  end

  def username
    user&.username
  end

  private

  def user
    begin
      User.find(object.user_id)
    rescue
      nil
    end
  end

  def currency_unit
    case object.currency
    when "eur"
      "€"
    when "gbp"
      "£"
    when "inr"
      "₹"
    when "brl"
      "R$"
    else
      "$"
    end
  end
end
