class PaymentApi

  def self.payment(credit_card_number, user_name, zip_code, amount)
    sleep(rand * 5)
    result = rand
    if result < 0.92
      return SecureRandom.hex
    elsif result < 0.95
      return "Insufficient funds"
    elsif result < 0.99
      return "Possible fraud"
    else
      sleep(rand * 10)
      raise "Ooops"
    end
  end

end
