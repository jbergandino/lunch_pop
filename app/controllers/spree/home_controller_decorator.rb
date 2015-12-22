Spree::HomeController.class_eval do

    def index
      @searcher = build_searcher(params.merge(include_images: true))
      @now = DateTime.now
      @products = @searcher.retrieve_products.where('expiration > ? AND start < ?', @now, @now)
      #where('price > ? AND price < ?', min, max)
      #@products = @searcher.retrieve_products.where("expiration > ?", now)
      @taxonomies = Spree::Taxonomy.includes(root: :children)
	end

end