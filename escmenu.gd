extends CanvasLayer




func _on_continue_pressed() -> void:
	$"..".hide_escmenu()


func _on_tomenu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menus/mainmenu.tscn")
