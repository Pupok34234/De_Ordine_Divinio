extends CanvasLayer


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel") and not Global.in_dialogue:
		if not $escmenu.visible:
			show_escmenu()
		else:
			hide_escmenu()
	
	$HBoxContainer/MarginContainer2/xp.text = "xp: " + str(Globalvars.xp)


func show_escmenu():
	get_tree().paused = true
	$escmenu.show()
	
	
func hide_escmenu():
	get_tree().paused = false
	$escmenu.hide()
	
	
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/mainmenu.tscn")
