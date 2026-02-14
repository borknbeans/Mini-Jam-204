extends VBoxContainer

# Intercept drag notifications to disable mouse interaction when dragging
func _notification(what: int) -> void:
	if what == Node.NOTIFICATION_DRAG_BEGIN:
		for button: BaseButton in get_children():
			button.mouse_filter = Control.MOUSE_FILTER_PASS
	elif what == Node.NOTIFICATION_DRAG_END:
		for button: BaseButton in get_children():
			button.mouse_filter = Control.MOUSE_FILTER_STOP
