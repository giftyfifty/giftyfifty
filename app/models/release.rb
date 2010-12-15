class Release < ActiveRecord::Base
  #
  # Associations
  #
  belongs_to :event
  
  include Ebay::Types
  
  def paypal(email)
    paypal = Gifty::Paypal.new
    amount = self.event.item.price
    response = paypal.call 'MassPay',{'L_EMAIL0' => email, 'L_AMT0' => amount, 'RECEIVERTYPE' => 'EmailAddress','CURRENCYCODE'=>'USD'}
    if response.ack == "Success"
      self.fill_release(amount, 'paypal')
    else
      false
    end
  end
  
  def ebay(client_ip)
    ebayapi = Ebay::Api.new
    item = self.event.item
    response = ebayapi.place_offer(:item_id => item.item_id, :end_user_ip => client_ip, :offer => Offer.new(:action => 'Purchase', :max_bid => Money.new(item.price, 'USD'), :quantity => 1))
    debugger
    if response.success
      self.fill_release(amount, 'paypal')
    else
      false
    end
  end
  
  def amazon
    
  end
  
  def balance
    
  end
  
  def fill_release(amount, type)
    self.amount = amount
    self.type = type
    self.save
  end
end
