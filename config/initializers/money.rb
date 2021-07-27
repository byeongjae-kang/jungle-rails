MoneyRails.configure do |config|

  Money.default_currency = Money::Currency.new("CAD")
  config.no_cents_if_whole = false
  Money.rounding_mode = BigDecimal::ROUND_HALF_EVEN
  Money.locale_backend = :i18n

end
