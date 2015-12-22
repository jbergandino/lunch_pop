 Spree::CheckoutController.class_eval do

 def update
      if @order.update_from_params(params, permitted_checkout_attributes, request.headers.env)
        @order.temporary_address = !params[:save_user_address]
        unless @order.next
          flash[:error] = @order.errors.full_messages.join("\n")
          redirect_to(checkout_state_path(@order.state)) && return
        end

        if @order.completed?
          
          # Subtract 1 from counter, Add 1 to deals sold counter 
          productId = Spree::LineItem.where(order_id:@current_order.id).first
          # Get the Quantity Ordered
          thisQuantity = productId.quantity

          product = Myproduct.find(productId.variant_id)
          counter = product.counter
          dealsSold = product.deals_sold
          if counter > 0
            newCounter = counter - thisQuantity
            newDealsSold = dealsSold + thisQuantity
          else
            newCounter = 0
            newDealsSold = dealsSold
          end

          spreeProduct = Spree::Product.find(productId.variant_id)
          spreeCounter = spreeProduct.counter
          spreeDealsSold = spreeProduct.deals_sold
          
          if spreeCounter > 0
            newSpreeCounter = spreeCounter - thisQuantity
            newSpreeDealsSold = spreeDealsSold + thisQuantity
          else
            newSpreeCounter = 0
            newSpreeDealsSold = spreeDealsSold
          end

          spreeProduct.update(counter:newSpreeCounter, deals_sold:newSpreeDealsSold)
          product.update(counter:newCounter, deals_sold:newDealsSold)

          @current_order = nil
          flash.notice = Spree.t(:order_processed_successfully)
          flash['order_completed'] = true
          redirect_to completion_route
        else
          redirect_to checkout_state_path(@order.state)
        end
      else
        render :edit
      end
    end

  end