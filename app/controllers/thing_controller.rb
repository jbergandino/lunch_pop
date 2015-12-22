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
    thisProductIdString = message[:name].to_s
    thisProductIdInt = thisProductIdString.to_i

    # Fetch value of this product's remaining inventory counter 
    thisProd = Myproduct.find(thisProductIdInt)
    if thisProd.counter > 0
      thisNewProductCount = thisProd.counter - 1
      thisDealsSold = thisProd.deals_sold + 1
    else
      thisNewProductCount = thisProd.counter
      thisDealsSold = thisProd.deals_sold
    end

    thisNewProductCountString = thisNewProductCount.to_s
    thisDealsSoldString = thisDealsSold.to_s
    # Concat the Product ID and the Counter so both get passed - will parse on view
    thisData = thisProductIdString << "-" << thisNewProductCountString << "_" << thisDealsSoldString

    # Trigger Broadcast with New Remaining Product Count
    WebsocketRails[:channel_updates].trigger 'boopcast', thisData

  end
end