extends CanvasLayer




func _on_playbutton_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_1.tscn")


func _on_quitbutton_pressed() -> void:
	get_tree().quit()
