class ContentfulGQL
  require 'gqli'
  extend GQLi::DSL

  SPACE_ID = Rails.application.credentials[Rails.env.to_sym][:contentful][:space_id]
  CF_ACCESS_TOKEN = Rails.application.credentials[Rails.env.to_sym][:contentful][:cf_access_token]

  class << self
    def execute(query)
      client ||= GQLi::Contentful.create(SPACE_ID, CF_ACCESS_TOKEN)

      client.execute(query)
    end

    def recipes_query
      query {
        recipeCollection {
          items {
            sys {
              id
            }
            title
            photo {
              url
            }
          }
        }
      }
    end

    def recipe_query(id)
      query {
        recipe(id: id) {
          title
          photo {
            url
          }
          tagsCollection {
            items {
              name
            }
          }
          description
          chef {
            name
          }
        }
      }
    end
  end
end
