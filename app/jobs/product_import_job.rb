class ProductImportJob < ApplicationJob
  queue_as :default

  def perform(link, stack_id)
    stack = Stack.find(stack_id)

    # check if the product already exists based on the link
    existing_product = Product.find_by(link: link)

    if existing_product
      existing_product.stacks << stack
    else
      # If the product doesn't exist, create a new one
      product = Product.new(link: link)
      product.stacks << stack
      ProductParser::Amazon.save_to_product(link, product)
    end
  end
end
