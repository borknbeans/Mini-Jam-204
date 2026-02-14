class_name IngredientTexturePanel extends Panel

func set_highlight(is_highlighted: bool) -> void:
	if (is_highlighted):
		const width = 1
		var style := StyleBoxFlat.new()
		style.border_color = Color.WHITE
		style.border_width_left = width
		style.border_width_top = width
		style.border_width_right = width
		style.border_width_bottom = width
		style.bg_color = Color.TRANSPARENT  # keep original look

		add_theme_stylebox_override("panel", style)
	else:
		remove_theme_stylebox_override("panel")

func set_correct() -> void:
	var style := StyleBoxFlat.new()
	style.bg_color = Color.WEB_GREEN  # keep original look
	
	add_theme_stylebox_override("panel", style)

func set_wrong_spot() -> void:
	var style := StyleBoxFlat.new()
	style.bg_color = Color.YELLOW  # keep original look
	
	add_theme_stylebox_override("panel", style)
