class_name Recipe extends Resource

var values: Array[RecipeSlot]

func add_ingredient(ingredient: Ingredient, count: int) -> void:
	values.append(RecipeSlot.new(ingredient, count))

## Treats itself as the "lock"
## Incoming recipe is checked as the "key"
func check_valid_solution(recipe: Recipe) -> void:
	for key_ingredient in recipe.values:
		var idx = _get_ingredient_idx(key_ingredient.ingredient)
		if idx == -1:
			print("idx: {} ingredient is not in this recipe")
	pass

## Returns the index of the ingredient in the recipe
## If the ingredient doesn't exist, returns -1
func _get_ingredient_idx(ingredient: Ingredient) -> int:
	for i in range(values.size()):
		if values[i].ingredient == ingredient:
			return i
	
	return -1

class RecipeSlot:
	var ingredient: Ingredient
	var count: int
	
	func _init(ingr: Ingredient, c: int) -> void:
		ingredient = ingr
		count = c
