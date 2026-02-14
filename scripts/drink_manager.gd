@tool
class_name DrinkManager extends Node

signal recipe_result(result: Array)

const ingredients_path: String = "res://resources/ingredients/"

@export var ingredients: Array[Ingredient]

var current_hidden_recipe: Recipe

func _ready() -> void:
	ingredients = _load_ingredients(ingredients_path)

func _process(_delta: float) -> void:
	if not Engine.is_editor_hint(): # Only run this when the game is going - not in the editor
		if Input.is_action_just_pressed("debug_new_recipe"):
			current_hidden_recipe = generate_recipe(5)
			current_hidden_recipe.debug_print()

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
	
	for i in range(size):
		var idx = randf_range(0, ingredients.size())
		var ingredient: Ingredient = ingredients.get(idx)
		var count = randi_range(1, 3)
		
		recipe.add_ingredient(ingredient, count)
	
	return recipe

func set_new_recipe(size: int) -> void:
	current_hidden_recipe = generate_recipe(size)
	print("Customers recipe:")
	current_hidden_recipe.debug_print()

func _on_drink_recipe_submitted(submitted_recipe: Recipe) -> void:
	var result: Array = current_hidden_recipe.check_valid_solution(submitted_recipe)
	recipe_result.emit(result)
