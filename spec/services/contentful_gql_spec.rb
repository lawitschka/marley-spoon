require 'rails_helper'

describe ContentfulGQL do
  it "builds a query for all recipes" do
    query = <<~GRAPHQL
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
    GRAPHQL

    expect(ContentfulGQL.recipes_query.to_gql).to eq query
  end

  it "builds a query for a single recipe" do
    query = <<~GRAPHQL
      query {
        recipe(id: 1) {
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
    GRAPHQL

    expect(ContentfulGQL.recipe_query(1).to_gql).to eq query
  end
end
