class Cart
  SessionKey = :cart88

  attr_reader :items

  def initialize(items = [])
    @items = items
  end

  def add_item(store_id, product_id)
    found_item = @items.find { |item| item.product_id == product_id && item.store_id == store_id}


    if found_item
      found_item.increment!
    else
      @items << CartItem.new(store_id, product_id)
    end
  end

  def empty?
    @items.empty?
  end

  def total_price
    @items.reduce(0) { |sum, item| sum + item.price }
  end

  def serialize
    all_items = @items.map { |item|
      { "store_id" => item.store_id, "product_id" => item.product_id, "quantity" => item.quantity }
    }
    { "items" => all_items }
  end

  def self.from_hash(hash = nil)
    if hash && hash["items"]
      items = []
      hash["items"].each do |item|
        items << CartItem.new(item["store_id"], item["product_id"], item["quantity"])
      end
      Cart.new(items)
    else
      Cart.new
    end
  end
end