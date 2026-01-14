if Rails.env.development?
  user = User.find_or_create_by!(email_address: "dev@cookery.local") do |record|
    record.password = "password123"
  end

  recipes = [
    {
      name: "Citrus Chickpea Salad",
      description: "Bright, crunchy, and quick. Great for a light lunch or a fresh side.",
      ingredients: [
        { name: "chickpeas", quantity: "400", unit: "g" },
        { name: "cucumber", quantity: "1", unit: "piece" },
        { name: "orange", quantity: "1", unit: "piece" },
        { name: "olive oil", quantity: "2", unit: "tbsp" },
        { name: "lemon juice", quantity: "1", unit: "tbsp" },
        { name: "salt", quantity: "1", unit: "pinch" }
      ],
      instructions: [
        "Rinse and drain the chickpeas.",
        "Dice cucumber and orange segments.",
        "Toss with olive oil and lemon juice.",
        "Season with salt and serve chilled."
      ]
    },
    {
      name: "One-Pot Tomato Pasta",
      description: "Cozy pantry pasta with a silky tomato sauce and minimal cleanup.",
      ingredients: [
        { name: "spaghetti", quantity: "200", unit: "g" },
        { name: "cherry tomatoes", quantity: "250", unit: "g" },
        { name: "garlic", quantity: "2", unit: "clove" },
        { name: "olive oil", quantity: "1", unit: "tbsp" },
        { name: "basil", quantity: "1", unit: "pinch" }
      ],
      instructions: [
        "Add pasta, tomatoes, and garlic to a pot with enough water to cover.",
        "Simmer until pasta is al dente, stirring occasionally.",
        "Stir in olive oil and tear in basil.",
        "Season and serve immediately."
      ]
    },
    {
      name: "Warm Apple Cinnamon Oats",
      description: "Comforting oats with tender apples and a touch of spice.",
      ingredients: [
        { name: "rolled oats", quantity: "1", unit: "cup" },
        { name: "milk", quantity: "1", unit: "cup" },
        { name: "apple", quantity: "1", unit: "piece" },
        { name: "cinnamon", quantity: "1", unit: "pinch" },
        { name: "maple syrup", quantity: "1", unit: "tbsp" }
      ],
      instructions: [
        "Dice the apple into small cubes.",
        "Simmer oats and milk until creamy.",
        "Stir in apple and cinnamon until softened.",
        "Finish with maple syrup."
      ]
    }
  ]

  recipes.each do |data|
    recipe = user.recipes.find_or_create_by!(name: data[:name]) do |record|
      record.description = data[:description]
    end

    if recipe.description != data[:description]
      recipe.update!(description: data[:description])
    end

    if recipe.ingredients.none?
      data[:ingredients].each do |ingredient|
        recipe.ingredients.create!(ingredient)
      end
    end

    if recipe.instructions.none?
      data[:instructions].each_with_index do |body, index|
        recipe.instructions.create!(body: body, position: index + 1)
      end
    end
  end
end
