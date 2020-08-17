class FetchRecipes
  require 'redcarpet'

  class MissingRecipeError < StandardError; end

  Recipe = Struct.new(:id, :title, :image_url, :tags, :description, :chef_name, keyword_init: true)

  class << self
    def all
      response = ContentfulGQL.execute(ContentfulGQL.recipes_query)

      response.data.recipeCollection.items.map do |recipe|
        Recipe.new(
          id: recipe.sys.id,
          title: recipe.title,
          image_url: recipe.photo&.url
        )
      end
    end

    def single(id)
      response = ContentfulGQL.execute(ContentfulGQL.recipe_query(id))
      recipe = response.data.recipe

      raise MissingRecipeError if recipe.nil?

      Recipe.new(
        title: recipe.title,
        image_url: recipe.photo&.url,
        tags: recipe.tagsCollection.items.map(&:name),
        description: markdown.render(recipe.description || ''),
        chef_name: recipe.chef&.name
      )
    end

    private

    def markdown
      renderer = Redcarpet::Render::HTML.new({})
      extensions = {}
      Redcarpet::Markdown.new(renderer, extensions)
    end
  end
end
