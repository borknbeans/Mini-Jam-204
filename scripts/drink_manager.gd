@tool
class_name DrinkManager extends Node

const ingredients_path: String = "res://resources/ingredients/"

@export var ingredients: Array[Ingredient]

func _ready() -> void:
	ingredients = _load_ingredients(ingredients_path)

func _load_ingredients(path: String) -> Array[Ingredient]:
	var rv: Array[Ingredient] = []
	
	var dir: DirAccess = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name: String = dir.get_next()
		while file_name != "":
			if file_name.get_extension() == "tres":
				var resource_path = path.path_join(file_name)
				
				var resource = ResourceLoader.load(resource_path)
				if resource:
					rv.append(resource)
			
			file_name = dir.get_next()
		dir.list_dir_end()
	
	return rv

func generate_recipe(size: int) -> Recipe:
	var recipe: Recipe = Recipe.new()
	
	var ingredients_copy: Array[Ingredient] = ingredients.duplicate()
	
	for i in range(size):
		if ingredients_copy.size() == 0:
			push_warning("Not enough ingredients to create a recipe of size " + str(size))
			break
		
		var idx = randf_range(0, ingredients_copy.size())
		var ingredient: Ingredient = ingredients_copy.pop_at(idx)
		var count = randi_range(1, 4)
		
		recipe.add_ingredient(ingredient, count)
	
	return recipe
