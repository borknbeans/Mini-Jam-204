class_name Recipe extends Resource

enum IngredientStatus {
	CORRECT,
	WRONG_POSITION,
	NOT_IN_RECIPE
}

enum CountStatus {
	CORRECT,
	WRONG,
	NOT_APPLICABLE
}

var values: Array[RecipeSlot]

func add_ingredient(ingredient: Ingredient, count: int) -> void:
	values.append(RecipeSlot.new(ingredient, count))

# Treats itself as the "lock"
# Incoming recipe is checked as the "key"
func check_valid_solution(recipe: Recipe) -> Array[SlotFeedback]:
	var feedback: Array[SlotFeedback] = []
	var used_lock_indices: Array[int] = [] # Track which lock slots we've already matched
	
	# First pass - find exact matches
	for key_idx in range(recipe.values.size()):
		var result = SlotFeedback.new()
		var key_slot = recipe.values[key_idx]
		
		if key_idx < values.size() and key_slot.ingredient == values[key_idx].ingredient:
			result.ingredient_status = IngredientStatus.CORRECT
			result.count_status = CountStatus.CORRECT if key_slot.count == values[key_idx].count else CountStatus.WRONG
			used_lock_indices.append(key_idx)
		else:
			# Will be resolved in second pass
			result.ingredient_status = IngredientStatus.NOT_IN_RECIPE
			result.count_status = CountStatus.NOT_APPLICABLE
		
		feedback.append(result)
	
	# Second pass - find wrong-position matches
	for key_idx in range(recipe.values.size()):
		if feedback[key_idx].ingredient_status == IngredientStatus.CORRECT:
			continue  # Already matched
		
		var key_slot = recipe.values[key_idx]
		
		# Look for this ingredient in other positions
		for lock_idx in range(values.size()):
			if lock_idx in used_lock_indices:
				continue  # Already used
			
			if key_slot.ingredient == values[lock_idx].ingredient:
				feedback[key_idx].ingredient_status = IngredientStatus.WRONG_POSITION
				feedback[key_idx].count_status = CountStatus.CORRECT if key_slot.count == values[lock_idx].count else CountStatus.WRONG
				used_lock_indices.append(lock_idx)
				break
			
	return feedback

func debug_print() -> void:
	for slot in values:
		print(slot.ingredient.name, " - ", slot.count)

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

class SlotFeedback:
	var ingredient_status: IngredientStatus
	var count_status: CountStatus
