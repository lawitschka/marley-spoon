require 'rails_helper'

describe FetchRecipes do
  let(:result) { double }
  let(:recipes_recipe) do
    double(
      sys: double(id: 1),
      title: 'title',
      photo: double(url: 'url')
    )
  end
  let(:recipe) do
    double(
      title: 'title',
      photo: double(url: 'url'),
      tagsCollection: double(items: [double(name: 'tag')]),
      description: 'description',
      chef: double(name: 'chef name')
    )
  end
  let(:recipe_with_missing_data) do
    double(
      title: nil,
      photo: nil,
      tagsCollection: double(items: []),
      description: nil,
      chef: nil
    )
  end
  let(:recipe_with_markdown) do
    double(
      title: nil,
      photo: nil,
      tagsCollection: double(items: []),
      description: '**test**',
      chef: nil
    )
  end

  before do
    allow(ContentfulGQL).to receive(:execute).and_return(result)
    allow(ContentfulGQL).to receive(:recipes_query)
    allow(ContentfulGQL).to receive(:recipe_query)
  end

  it "returns a list of recipes" do
    expectation = [FetchRecipes::Recipe.new(id: 1, title: 'title', image_url: 'url')]

    expect(result).to receive_message_chain(:data, :recipeCollection, :items) { [recipes_recipe] }

    expect(FetchRecipes.all).to eq expectation
  end

  it "returns a recipe" do
    expectation = FetchRecipes::Recipe.new(
      title: 'title',
      image_url: 'url',
      tags: ['tag'],
      description: "<p>description</p>\n",
      chef_name: 'chef name'
    )

    expect(result).to receive_message_chain(:data, :recipe) { recipe }

    expect(FetchRecipes.single(1)).to eq expectation
  end

  it "returns a recipe with missing data" do
    expectation = FetchRecipes::Recipe.new(tags: [], description: '')

    expect(result).to receive_message_chain(:data, :recipe) { recipe_with_missing_data }

    expect(FetchRecipes.single(1)).to eq expectation
  end

  it "parses markdown in the description" do
    expectation = FetchRecipes::Recipe.new(tags: [], description: "<p><strong>test</strong></p>\n")

    expect(result).to receive_message_chain(:data, :recipe) { recipe_with_markdown }

    expect(FetchRecipes.single(1)).to eq expectation
  end

  it "raises an error when recipe is missing" do
    expect(result).to receive_message_chain(:data, :recipe) { nil }

    expect { FetchRecipes.single(1) }.to raise_error(FetchRecipes::MissingRecipeError)
  end
end
