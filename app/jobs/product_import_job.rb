class ProductImportJob < ApplicationJob
  queue_as :default

  def perform(link, stack_id)
    stack = Stack.find(stack_id)
    imported_product = nil
    # check if the product already exists based on the link
    existing_product = Product.find_by(link: link)

    if existing_product
      imported_product = existing_product.stacks << stack
    else
      # If the product doesn't exist, create a new one
      product = Product.new(link: link)
      product.stacks << stack
      imported_product = ProductParser::Amazon.save_to_product(link, product)
    end

    broadcast_turbo_stream(stack, imported_product)
  end

  private

  def broadcast_turbo_stream(stack, product)
    Turbo::StreamsChannel.broadcast_replace_to(
      stack,
      target: "product_list_#{stack.id}",
      partial: "stacks/product_list",
      locals: { stack: stack }
    )

    Turbo::StreamsChannel.broadcast_replace_to(
      stack,
      target: "products_count_#{stack.id}",
      partial: "stacks/stack_product_count",
      locals: { stack: stack }
    )
  end
end
