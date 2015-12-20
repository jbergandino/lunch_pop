class ThingController < WebsocketRails::BaseController
  def person_joined
    WebsocketRails[:channel_updates].trigger 'new_person', 'a new person joined'
  end

  def broadcast_boop
  	# broadcast whenever counter goes down

  	# in controller where product is purchased, broadcast the new counter variable 

  	# on show page, thats where i receive broadcast 

  	# get handshake working first 

  	# getting a message and sending one have nothing to do with each other

  	#set trigger on the purchase button
    # WebsocketRails[:channel_updates].trigger 'boopcast', message[:name]
    
    # Get the Product Id that Changed
    thisProductId = message[:name].to_i

    # Fetch value of this product's remaining inventory counter 
    newProductCount = Myproduct.find(thisProductId).counter - 1
    # Trigger Broadcast with New Remaining Product Count
    WebsocketRails[:channel_updates].trigger 'boopcast', newProductCount

  end
end