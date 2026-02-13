class_name Recipe extends Resource

enum SlotCheckStatus {
	CORRECT,
	NOT_USED,
	CORRECT_SLOT_WRONG_COUNT,
	WRONG_SLOT_CORRECT_COUNT,
	WRONG_SLOT_WRONG_COUNT,
}

var values: Array[RecipeSlot]

func add_ingredient(ingredient: Ingredient, count: int) -> void:
	values.append(RecipeSlot.new(ingredient, count))

## Treats itself as the "lock"
## Incoming recipe is checked as the "key"
func check_valid_solution(recipe: Recipe) -> void: # TODO(eb): Handle how this return type should look
	for key_idx in range(recipe.values.size()):
		var key_ingredient = recipe.values[key_idx]
		var lock_idx = _get_ingredient_idx(key_ingredient.ingredient)
		var lock_ingredient = values[lock_idx]
		if lock_idx == -1:
			print("idx: {} ingredient is not in this recipe", key_idx)
			# SlotCheckStatus.NOT_USED
			return
		# Else this ingredient exists
		if key_idx == lock_idx:
			if key_ingredient.count == lock_ingredient.count:
				print("idx: {} ingredient is a match and has the same count!", key_idx)
				# SlotCheckStatus.CORRECT
				return
			else:
				print("idx: {} ingredient is a match but does NOT have the same count!", key_idx)
				# SlotCheckStatus.CORRECT_SLOT_WRONG_COUNT
				return
		else: # Not in the correct spot
			if key_ingredient.count == lock_ingredient.count:
				print("idx: {} ingredient is in wrong spot but has the same count!", key_idx)
				# SlotCheckStatus.WRONG_SLOT_CORRECT_COUNT
				return
			else:
				print("idx: {} ingredient is is in wrong spot and does NOT have the same count!", key_idx)
				# SlotCheckStatus.WRONG_SLOT_WRONG_COUNT
				return

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
