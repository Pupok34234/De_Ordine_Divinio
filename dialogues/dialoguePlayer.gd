extends CanvasLayer


class_name DialogueSystem
@export var d_file : String
var x : DialogueSystem

var dialogue_system : DialogueSystem
var current_dialogue_index := 0
@onready var rich_text_label = $NinePatchRect/chat

var dialogues := {}


func _ready():
	dialogue_system = DialogueSystem.new()
	rich_text_label = $NinePatchRect/chat
	load_dialogues(d_file)
	display_current_dialogue()


func load_dialogues(file_path: String) -> void:
	var json_content = ResourceLoader.load(file_path).get_as_text()
	
func display_current_dialogue() -> void:
  if current_dialogue_index < dialogue_system.dialogues.size():
	   var dialogue = dialogue_system.get_dialogue(dialogues.keys()[current_dialogue_index])
	   rich_text_label.bbcode_enabled = true
	   rich_text_label.bbcode_text = "[b]%s[/b]: %s" % [dialogue["text"]]
	   current_dialogue_index += 1

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		display_current_dialogue()

#
#
#var dialogue = []
#
#func _ready() -> void:
	#start()
#func start():
	#dialogue = load_dialogue(d_file)
	#
	#$NinePatchRect/name.text = dialogue[0]['name']
	#$NinePatchRect/chat.text = dialogue[0]['text']
#
#func load_dialogue(file_path: String):
	#ResourceLoader.load(d_file).get_as_text()
	#
	
