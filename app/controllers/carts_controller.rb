class CartsController < ApplicationController

  def add_item
    product_id = params[:product_id].to_s
    update_cart(product_id, 1)
    redirect_to cart_path
  end

  def remove_item
    product_id = params[:product_id].to_s
    update_cart(product_id, -1)
    redirect_to cart_path
  end

  private

  def update_cart(product_id, delta)
    cart = cookies[:cart].present? ? JSON.parse(cookies[:cart]) : {}
    cart[product_id] = (cart[product_id] || 0) + delta
    cart.delete(product_id) if cart[product_id] < 1
    cookies[:cart] = {
      value: JSON.generate(cart),
      expires: 10.days.from_now
    }
    cart
  end
end
